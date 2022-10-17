import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_in_password.dart';

class AuthenticationWithEmailAndPassword {
  final IAuthenticationRepository _repository;
  final IAppConfiguration _appConfiguration;

  AuthenticationWithEmailAndPassword({
    required IAuthenticationRepository authenticationRepository,
    required IAppConfiguration appConfiguration,
  })  : this._repository = authenticationRepository,
        this._appConfiguration = appConfiguration;

  Future<SessionEntity>  call({
    required EmailAddress email,
    required SignInPassword password,
  }) {
    return _repository
        .signInWithEmailAndPassword(emailAddress: email, password: password)
        .then(_saveAuthenticationToken);
  }

  Future<SessionEntity> _saveAuthenticationToken(SessionEntity session) async {
    await _appConfiguration.saveApiToken(token: session.sessionToken);
    return session;
  }
}
