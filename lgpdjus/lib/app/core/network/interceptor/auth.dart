import 'package:http/http.dart';
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/core/network/interceptor/interceptor.dart';

class AuthInterceptor implements HttpInterceptor {
  AuthInterceptor(this._appConfiguration);

  final IAppConfiguration _appConfiguration;

  @override
  Future<StreamedResponse> intercept(
    BaseRequest request,
    Next next,
  ) async {
    final token = await _appConfiguration.apiToken ?? "";
    if (token.isNotEmpty) {
      request.headers['X-Api-Key'] = token;
    }
    return next(request);
  }
}
