import 'package:dartz/dartz.dart';
import 'package:lgpdjus/app/core/entities/valid_fiel.dart';
import 'package:lgpdjus/app/core/error/failures.dart';
import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/cpf.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/full_name.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/nickname.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_up_password.dart';

abstract class IUserRegisterRepository {
  Future<SessionEntity> signup({
    required EmailAddress emailAddress,
    required SignUpPassword password,
    required Cpf cpf,
    required Fullname fullname,
    required Nickname nickName,
  });

  Future<ValidField> checkField({
    EmailAddress? emailAddress,
    SignUpPassword? password,
    Cpf? cpf,
    Fullname? fullname,
    Nickname? nickName,
  });
}
