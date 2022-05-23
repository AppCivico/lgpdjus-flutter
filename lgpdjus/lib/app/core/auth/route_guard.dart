import 'package:flutter_modular/flutter_modular.dart';
import 'package:lgpdjus/app/core/auth/authentication.dart';
import 'package:lgpdjus/app/core/data/authorization_status.dart';

class AuthGuard extends RouteGuard {
  AuthGuard(
    AuthenticationObserver authenticationObserver,
  ) : super("/authentication") {
    authenticationObserver.observeWith(updateAuthStatus);
  }

  AuthorizationStatus authorizationStatus = AuthorizationStatus.anonymous;

  void updateAuthStatus(AuthorizationStatus status) {
    authorizationStatus = status;
  }

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    return authorizationStatus.isAuthenticated;
  }
}
