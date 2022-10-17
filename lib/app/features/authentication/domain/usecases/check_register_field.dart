import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/authentication/domain/repositories/i_user_register_repository.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/cpf.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/full_name.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/nickname.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';

class CheckRegisterField {
  final IUserRegisterRepository repository;

  CheckRegisterField(this.repository);

  Future<ValidField> call({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cpf? cpf,
    Fullname? fullname,
    Nickname? nickName,
  }) {
    if (emailAddress == null &&
        password == null &&
        cpf == null &&
        fullname == null &&
        nickName == null) {
      throw RequiredParameter();
    }

    return repository.checkField(
      emailAddress: emailAddress,
      password: password,
      cpf: cpf,
      fullname: fullname,
      nickName: nickName,
    );
  }
}
