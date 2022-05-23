import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/network/network_info.dart';
import 'package:lgpdjus/app/features/authentication/data/datasources/change_password_data_source.dart';
import 'package:lgpdjus/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';

class ChangePasswordRepository
    implements IResetPasswordRepository, IChangePasswordRepository {
  final IChangePasswordDataSource _dataSource;

  ChangePasswordRepository({
    required IChangePasswordDataSource changePasswordDataSource,
    required INetworkInfo networkInfo,
  }) : this._dataSource = changePasswordDataSource;

  @override
  Future<ResetPasswordResponseEntity> request({
    required EmailAddress emailAddress,
  }) async {
    final ResetPasswordResponseEntity result =
        await _dataSource.request(emailAddress: emailAddress);
    return result;
  }

  @override
  Future<ValidField> reset({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required String resetToken,
  }) async {
    await _dataSource.reset(
      emailAddress: emailAddress,
      password: password,
      resetToken: resetToken,
    );
    return ValidField();
  }

  @override
  Future<ValidField> validToken({
    required EmailAddress emailAddress,
    required String resetToken,
  }) async {
    await _dataSource.validToken(
      emailAddress: emailAddress,
      resetToken: resetToken,
    );
    return ValidField();
  }
}
