import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';
import 'package:meta/meta.dart';

@immutable
class ChangePassword {
  final IChangePasswordRepository _repository;

  factory ChangePassword(
      {required IChangePasswordRepository changePasswordRepository}) {
    return ChangePassword._(changePasswordRepository);
  }

  ChangePassword._(this._repository);

  Future<ValidField> call({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required String resetToken,
  }) {
    return _repository.reset(
      emailAddress: emailAddress,
      password: password,
      resetToken: resetToken,
    );
  }
}
