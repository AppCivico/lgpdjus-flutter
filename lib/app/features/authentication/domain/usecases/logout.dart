import 'package:lgpdjus/app/core/managers/app_configuration.dart';

class LogoutUseCase {
  LogoutUseCase(this._appConfigure);

  final IAppConfiguration _appConfigure;

  Future<void> call() => _appConfigure.logout();
}