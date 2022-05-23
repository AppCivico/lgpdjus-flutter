import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:lgpdjus/app/core/error/exceptions.dart';
import 'package:lgpdjus/app/core/extension/http.dart';
import 'package:lgpdjus/app/core/network/api_server_configure.dart';
import 'package:lgpdjus/app/core/network/interceptor/interceptor.dart';
import 'package:lgpdjus/app/core/network/network_info.dart';

class ApiClient extends BaseClient {
  ApiClient(
      this.baseUrl, [
    this.interceptors = const [],
  ]);

  final Uri baseUrl;
  final List<HttpInterceptor> interceptors;

  Next get _sendRequest => _proceed();

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    BaseRequest newRequest = request.copyWith(
      url: baseUrl.resolveUri(request.url),
    );
    return _sendRequest(newRequest);
  }

  Next _proceed([int index = 0]) {
    return (BaseRequest request) {
      if (index < interceptors.length) {
        final HttpInterceptor next = interceptors[index];
        return next.intercept(request, _proceed(index + 1));
      }
      if (request is MultipartRequest)
        return request.send();
      return Client().send(request);
    };
  }
}

@Deprecated("Use http.Client instead")
abstract class IApiProvider {
  Future<String> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String?>? parameters,
  });

  Future<String> post({
    required String path,
    Map<String, String>? headers,
    Map<String, String?>? parameters,
    String? body,
  });

  Future<String> delete({
    required String path,
    Map<String, String?>? parameters,
  });

  Future<String> upload({
    required String path,
    required MultipartFile file,
    Map<String, String>? headers,
    Map<String, String>? fields,
  });

  Future<String> download({
    required String path,
    required File file,
    Map<String, String>? headers,
    Map<String, String>? fields,
  });
}

@Deprecated("Use http.Client instead")
class ApiProvider implements IApiProvider {
  final INetworkInfo _networkInfo;
  final IApiServerConfigure _serverConfiguration;

  ApiProvider({
    required IApiServerConfigure serverConfiguration,
    required INetworkInfo networkInfo,
  })  : this._serverConfiguration = serverConfiguration,
        this._networkInfo = networkInfo;

  @override
  Future<String> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String?>? parameters,
  }) async {
    headers ??= {};
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await setupHttpHeader(headers);
    return Client()
        .get(uriRequest, headers: header)
        .parseError(_networkInfo)
        .then((response) => response.body);
  }

  @override
  Future<String> post({
    required String path,
    Map<String, String>? headers,
    Map<String, String?>? parameters,
    String? body,
  }) async {
    headers ??= {};
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await setupHttpHeader(headers);
    return Client()
        .post(uriRequest, headers: header, body: body)
        .parseError(_networkInfo)
        .then((response) => response.body);
  }

  @override
  Future<String> delete(
      {required String path, Map<String, String?>? parameters}) async {
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: parameters,
    );
    final header = await setupHttpHeader({});
    return Client()
        .delete(uriRequest, headers: header)
        .parseError(_networkInfo)
        .then((response) => response.body);
  }

  @override
  Future<String> upload({
    required String path,
    required MultipartFile file,
    Map<String, String>? headers,
    Map<String, String>? fields,
  }) async {
    headers ??= {};
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: {},
    );
    final header = await setupHttpHeader(headers);
    final MultipartRequest request = MultipartRequest('POST', uriRequest);
    final cleanedField = fields == null ? Map<String, String>() : fields;
    request
      ..headers.addAll(header)
      ..fields.addAll(cleanedField)
      ..files.add(file);

    return request
        .send()
        .parseError(_networkInfo)
        .then((response) => response.stream.bytesToString());
  }

  @override
  Future<String> download({
    required String path,
    required File file,
    Map<String, String>? headers,
    Map<String, String>? fields,
  }) async {
    headers ??= {};
    final Uri uriRequest = setupHttpRequest(
      path: path,
      queryParameters: fields,
    );

    final header = await setupHttpHeader(headers);
    return Client()
        .get(uriRequest, headers: header)
        .parseError(_networkInfo)
        .then((response) => file.writeAsBytesSync(response.bodyBytes))
        .then((value) => '{"message": "Ok"}');
  }
}

extension _ApiProvider on ApiProvider {
  Future<Map<String, String>> setupHttpHeader(
      Map<String, String>? headers) async {
    headers ??= {};
    headers.addAll(
      {
        'X-Api-Key': await _serverConfiguration.apiToken ?? "",
        'User-Agent': await _serverConfiguration.userAgent,
      },
    );

    if (!headers.containsKey('Content-Type')) {
      headers['Content-Type'] =
          'application/x-www-form-urlencoded; charset=utf-8';
    }

    return headers;
  }

  Uri setupHttpRequest({
    required String path,
    required Map<String, String?>? queryParameters,
  }) {
    queryParameters ??= {};
    queryParameters.removeWhere((k, v) => v == null);
    return _serverConfiguration.baseUri.replace(
      path: path,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }
}

extension _FutureExtension<T extends BaseResponse> on Future<T> {
  Future<T> parseError(INetworkInfo networkInfo) async {
    final Set<int> successfulResponse = {200, 201, 204};
    final Set<int> invalidSessionCode = {401, 403};
    final Set<int> serverExceptions = {500, 501, 502, 503, 504, 505};

    return this.then(
      (value) async {
        final statusCode = value.statusCode;

        if (successfulResponse.contains(statusCode)) {
          return Future.value(value);
        } else if (invalidSessionCode.contains(statusCode)) {
          throw ApiProviderSessionExpection();
        } else if (serverExceptions.contains(statusCode)) {
          throw NetworkServerException();
        } else {
          if (!await networkInfo.isConnected) {
            throw InternetConnectionException();
          }

          String? jsonData;
          if (value is StreamedResponse) {
            jsonData = await value.stream.bytesToString();
          } else if (value is Response) {
            jsonData = value.body;
          }

          Map<String, dynamic> bodyContent = Map<String, dynamic>();
          try {
            bodyContent = jsonDecode(jsonData!);
          } catch (e) {
            bodyContent = {'parserError': e.toString()};
          }

          throw ApiProviderException(bodyContent: bodyContent);
        }
      },
    );
  }
}
