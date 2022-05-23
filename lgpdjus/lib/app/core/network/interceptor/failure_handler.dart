import 'dart:io';

import 'package:http/http.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/core/extension/http.dart';
import 'package:lgpdjus/app/core/network/interceptor/interceptor.dart';
import 'package:lgpdjus/app/shared/logger/log.dart';

class FailureHandlerInterceptor implements HttpInterceptor {
  @override
  Future<StreamedResponse> intercept(
    BaseRequest request,
    Next next,
  ) {
    return next(request).then(_handleFailure).catchError(_handleError);
  }

  Future<T> _handleFailure<T extends BaseResponse>(T response) async {
    if (response.isSuccessful) return response;

    if (response.hasAuthenticationError) throw ServerSideSessionFailed();
    if (response.hasServerError)
      throw ServerFailure(HttpException(
        "reason=`${response.reasonPhrase}`, statusCode=${response.statusCode}",
        uri: response.request?.url,
      ));

    Map<String, dynamic> bodyContent = Map<String, dynamic>();
    try {
      bodyContent = await response.bodyJson;
    } catch (e) {
      throw ServerFailure(e);
    }

    if (bodyContent.containsKey("error")) {
      if (bodyContent['error'] == 'expired_jwt')
        throw ServerSideSessionFailed();
      if (bodyContent['error'] == 'no-gps')
        throw GpsFailure(bodyContent['message']);
      if (bodyContent['error'] == 'location_not_found')
        throw AddressFailure(bodyContent['message']);
      if (bodyContent['error'] == 'must_verify_account')
        throw UnverifiedAccountFailure(bodyContent['message']);

      throw ServerSideFormFieldValidationFailure(
          error: bodyContent['error'],
          field: bodyContent['field'],
          reason: bodyContent['reason'],
          message: bodyContent['message']);
    }

    throw ServerFailure();
  }

  Future<StreamedResponse> _handleError(
    Object exception, [
    StackTrace? stack,
  ]) async {
    error(exception, stack);
    if (exception is FileSystemException) throw FileSystemFailure();
    throw exception;
  }
}
