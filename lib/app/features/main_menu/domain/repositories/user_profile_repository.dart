import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/core/network/api_client.dart';
import 'package:lgpdjus/app/core/network/api_server_configure.dart';
import 'package:lgpdjus/app/features/authentication/presentation/shared/map_exception_to_failure.dart';
import 'package:lgpdjus/app/features/main_menu/data/model/account_preference_model.dart';

abstract class IUserProfileRepository {
  Future<Either<Failure, ValidField>> deleteNotice();
  Future<Either<Failure, ValidField>> reactivate({required String token});
  Future<Either<Failure, AccountPreferenceSessionModel>> preferences();
  Future<Either<Failure, AccountPreferenceSessionModel>> updatePreferences({
    required String key,
    required bool status,
  });
}

class UserProfileRepository implements IUserProfileRepository {
  final IApiProvider _apiProvider;
  final IApiServerConfigure _serverConfiguration;

  UserProfileRepository({
    required IApiProvider apiProvider,
    required IApiServerConfigure serverConfiguration,
  })   : this._apiProvider = apiProvider,
        this._serverConfiguration = serverConfiguration;

  @override
  Future<Either<Failure, ValidField>> deleteNotice() async {
    final endPoint = ['me', 'account-disable-text'].join('/');

    try {
      final response = await _apiProvider.get(path: endPoint).parseValidField();
      return right(response);
    } catch (error, stack) {
      return left(MapExceptionToFailure.map(error, stack));
    }
  }

  @override
  Future<Either<Failure, ValidField>> reactivate(
      {required String token}) async {
    final endPoint = '/reactivate';

    final parameters = {
      'app_version': await _serverConfiguration.userAgent,
      'api_key': token,
    };

    try {
      await _apiProvider.post(path: endPoint, parameters: parameters);
      return right(ValidField(message: token));
    } catch (error, stack) {
      return left(MapExceptionToFailure.map(error, stack));
    }
  }

  @override
  Future<Either<Failure, AccountPreferenceSessionModel>> preferences() async {
    final endPoint = '/me/preferences';

    try {
      final data = await _apiProvider.get(path: endPoint);
      final jsonData = jsonDecode(data) as Map<String, dynamic>;
      final session = AccountPreferenceSessionModel.fromJson(jsonData);
      return right(session);
    } catch (error, stack) {
      return left(MapExceptionToFailure.map(error, stack));
    }
  }

  @override
  Future<Either<Failure, AccountPreferenceSessionModel>> updatePreferences(
      {required String key, required bool status}) async {
    final endPoint = '/me/preferences';
    final parameters = {key: status ? "1" : "0"};

    try {
      final data =
          await _apiProvider.post(path: endPoint, parameters: parameters);
      final jsonData = jsonDecode(data) as Map<String, dynamic>;
      final session = AccountPreferenceSessionModel.fromJson(jsonData);
      return right(session);
    } catch (error, stack) {
      return left(MapExceptionToFailure.map(error, stack));
    }
  }
}
