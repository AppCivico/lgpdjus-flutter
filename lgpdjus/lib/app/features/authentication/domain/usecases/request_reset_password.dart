import 'package:lgpdjus/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';

class RequestResetPassword {
  final IResetPasswordRepository _repository;

  factory RequestResetPassword(
      {required IResetPasswordRepository resetPasswordRepository}) {
    return RequestResetPassword._(resetPasswordRepository);
  }

  RequestResetPassword._(this._repository);

  Future<ResetPasswordResponseEntity> call({
    required EmailAddress email,
  }) {
    return _repository.request(emailAddress: email);
  }
}
