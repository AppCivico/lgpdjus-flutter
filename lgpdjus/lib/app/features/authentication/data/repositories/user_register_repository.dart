import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/managers/app_configuration.dart';
import 'package:lgpdjus/app/core/network/network_info.dart';
import 'package:lgpdjus/app/features/authentication/data/datasources/user_register_data_source.dart';
import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/cpf.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/full_name.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/nickname.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';

class UserRegisterRepository implements IUserRegisterRepository {
  final IUserRegisterDataSource _dataSource;
  final IAppConfiguration _appConfiguration;

  UserRegisterRepository({
    required INetworkInfo networkInfo,
    required IAppConfiguration appConfiguration,
    required IUserRegisterDataSource dataSource,
  })  : this._dataSource = dataSource,
        this._appConfiguration = appConfiguration;

  @override
  Future<ValidField> checkField({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cpf? cpf,
    Fullname? fullname,
    Nickname? nickName,
  }) async {
    await _dataSource.checkField(
      emailAddress: emailAddress,
      password: password,
      cpf: cpf,
      fullname: fullname,
      nickName: nickName,
    );

    return ValidField();
  }

  @override
  Future<SessionEntity> signup({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required Cpf cpf,
    required Fullname fullname,
    required Nickname nickName,
  }) async {
    final session = await _dataSource.register(
      emailAddress: emailAddress,
      password: password,
      cpf: cpf,
      fullname: fullname,
      nickName: nickName,
    );

    await _appConfiguration.saveApiToken(token: session.sessionToken);

    return SessionEntity(
      sessionToken: session.sessionToken,
      deletedScheduled: session.deletedScheduled,
    );
  }
}
