import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/features/authentication/data/datasources/authentication_data_source.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationDataSource _dataSource;
  final IAppConfiguration _appConfiguration;

  AuthenticationRepository({
    required IAppConfiguration appConfiguration,
    required IAuthenticationDataSource dataSource,
  })  : this._dataSource = dataSource,
        this._appConfiguration = appConfiguration;

  @override
  Future<String> getLoginUrl() async {
    final result = await _dataSource.getLoginSession();

    // await _appConfiguration.saveApiToken(token: result.token);

    return result.url;
  }
}
