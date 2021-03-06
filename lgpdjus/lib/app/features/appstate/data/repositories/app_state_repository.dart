import 'package:dartz/dartz.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:lgpdjus/app/core/error/exceptions.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/core/network/network_info.dart';
import 'package:lgpdjus/app/features/appstate/data/datasources/app_state_data_source.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:lgpdjus/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:lgpdjus/app/features/appstate/domain/repositories/i_app_state_repository.dart';

class AppStateRepository implements IAppStateRepository {
  final INetworkInfo _networkInfo;
  final IAppStateDataSource _dataSource;

  AppStateRepository({
    required INetworkInfo networkInfo,
    required IAppStateDataSource dataSource,
  })  : this._dataSource = dataSource,
        this._networkInfo = networkInfo;

  @override
  Future<Either<Failure, AppStateEntity>> check() async {
    try {
      final appState = await _dataSource.check();
      return right(appState);
    } catch (e, stacktrace) {
      return left(await _handleError(e, stacktrace));
    }
  }

  @override
  Future<Either<Failure, AppStateEntity>> update(
      UpdateUserProfileEntity update) async {
    try {
      final appState = await _dataSource.update(update);
      return right(appState);
    } catch (e, stacktrace) {
      return left(await _handleError(e, stacktrace));
    }
  }

  Future<Failure> _handleError(Object error, StackTrace stackTrace) async {
    if (await _networkInfo.isConnected == false) {
      return InternetConnectionFailure();
    }

    if (error is ApiProviderException) {
      if (error.bodyContent['error'] == 'expired_jwt') {
        return ServerSideSessionFailed();
      }

      return ServerSideFormFieldValidationFailure(
          error: error.bodyContent['error'],
          field: error.bodyContent['field'],
          reason: error.bodyContent['reason'],
          message: error.bodyContent['message']);
    }

    if (error is ApiProviderSessionExpection) {
      return ServerSideSessionFailed();
    }

    FirebaseCrashlytics.instance.recordError(error, stackTrace);

    return ServerFailure();
  }
}
