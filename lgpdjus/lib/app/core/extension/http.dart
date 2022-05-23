import 'dart:convert';

import 'package:http/http.dart';

Map<String, String> contentTypeFormUrlencoded = {
  'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
};

Map<String, String> contentTypeJson = {
  'Content-Type': 'application/json; charset=utf-8',
};

final Set<int> _successfulStatusCodes = {200, 201, 204};
final Set<int> _authenticationErrorStatusCodes = {401, 403};
final Set<int> _serverErrorStatusCodes = {500, 501, 502, 503, 504, 505};

extension ToJson on Response {
  dynamic get bodyJson => json.decode(body);
}

extension ResponseHelpers on BaseResponse {
  Future<dynamic> get bodyJson async {
    final String jsonData;
    if (this is StreamedResponse) {
      jsonData = await (this as StreamedResponse).stream.bytesToString();
    } else if (this is Response) {
      jsonData = (this as Response).body;
    } else {
      throw Exception("Invalid response type '${this.runtimeType}'");
    }
    return json.decode(jsonData);
  }

  bool get isSuccessful => _successfulStatusCodes.contains(statusCode);

  bool get hasAuthenticationError =>
      _authenticationErrorStatusCodes.contains(statusCode);

  bool get hasServerError => _serverErrorStatusCodes.contains(statusCode);
}

extension CloneRequest<T extends BaseRequest> on T {
  BaseRequest copyWith({
    String? method,
    Uri? url,
    Map<String, String>? headers,
  }) {
    final other = this;
    late final BaseRequest newRequest;

    if (other is Request) {
      newRequest = Request(method ?? other.method, url ?? other.url)
        ..encoding = other.encoding
        ..bodyBytes = other.bodyBytes;
    } else if (other is MultipartRequest) {
      newRequest = MultipartRequest(method ?? other.method, url ?? other.url)
        ..fields.addAll(other.fields)
        ..files.addAll(other.files);
    } else {
      throw UnsupportedError(
          "Unsupported request type `${runtimeType.toString()}`");
    }

    return newRequest..headers.addAll(headers ?? other.headers);
  }
}

extension UploadFiles on Client {
  Future<StreamedResponse> upload(
    Uri url,
    List<MultipartFile> files, {
    String method = 'POST',
    Map<String, String> fields = const <String, String>{},
  }) {
    final request = MultipartRequest(method, url)
      ..files.addAll(files)
      ..fields.addAll(fields);
    return send(request);
  }
}
