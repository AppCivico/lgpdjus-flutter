import 'package:lgpdjus/app/features/authentication/domain/usecases/cpf.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/full_name.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/nickname.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';

class UserRegisterFormFieldModel {
  Fullname fullname = Fullname('');
  Cpf cpf = Cpf('');
  Nickname nickname = Nickname('');
  EmailAddress emailAddress = EmailAddress('');

  SignUpPassword? password;
  String passwordConfirmation = "";
  String token = "";

  String get validateFullName => fullname.mapFailure;

  String get validateCpf => cpf.mapFailure;

  String get validateEmailAddress => emailAddress.mapFailure;

  String get validateNickname => nickname.mapFailure;

  String get validatePasswordConfirmation =>
      password?.rawValue == passwordConfirmation
          ? ''
          : 'As senhas não são iguais';
}
