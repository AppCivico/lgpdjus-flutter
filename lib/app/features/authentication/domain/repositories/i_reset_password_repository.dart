import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';

abstract class IResetPasswordRepository {
  Future<ResetPasswordResponseEntity> request({
    required EmailAddress emailAddress,
  });
}

abstract class IChangePasswordRepository {
  Future<ValidField> validToken({
    required EmailAddress emailAddress,
    required String resetToken,
  });

  Future<ValidField> reset({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required String resetToken,
  });
}
