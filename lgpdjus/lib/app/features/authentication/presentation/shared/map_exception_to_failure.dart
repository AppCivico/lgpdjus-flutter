import 'dart:io';

import 'package:lgpdjus/app/core/error/exceptions.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/shared/logger/log.dart' as logger;

@Deprecated("Will be removed soon")
class MapExceptionToFailure {
  static Failure map(Object error, [StackTrace? stack]) {
    if (error is! InternetConnectionFailure)
      logger.error(error, stack);

    if (error is InternetConnectionException)
      return InternetConnectionFailure();
    else if (error is ApiProviderSessionExpection)
      return ServerSideSessionFailed();
    else if (error is NetworkServerException)
      return ServerFailure();
    else if (error is FileSystemException) return FileSystemFailure();

    if (error is ApiProviderException) {
      if (error.bodyContent['error'] == 'expired_jwt') {
        return ServerSideSessionFailed();
      }
      if (error.bodyContent['error'] == 'no-gps') {
        return GpsFailure(error.bodyContent['message']);
      }
      if (error.bodyContent['error'] == 'location_not_found') {
        return AddressFailure(error.bodyContent['message']);
      }

      return ServerSideFormFieldValidationFailure(
          error: error.bodyContent['error'],
          field: error.bodyContent['field'],
          reason: error.bodyContent['reason'],
          message: error.bodyContent['message']);
    }

    return ServerFailure();
  }
}
