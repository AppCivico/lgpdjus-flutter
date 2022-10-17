import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_in_password.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationDataSource _dataSource;
  final IAppConfiguration _appConfiguration;

  AuthenticationRepository({
    required IAppConfiguration appConfiguration,
    required IAuthenticationDataSource dataSource,
  })  : this._dataSource = dataSource,
        this._appConfiguration = appConfiguration;

  @override
  Future<SessionEntity> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required SignInPassword password,
  }) async {
    final result = await _dataSource.signInWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );

    if (!result.deletedScheduled) {
      await _appConfiguration.saveApiToken(token: result.sessionToken);
    }

    return result;
  }
}
