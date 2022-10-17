import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/email_address.dart';
import 'package:lgpdjus/app/features/authentication/domain/usecases/sign_in_password.dart';

abstract class IAuthenticationRepository {
  Future<SessionEntity> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required SignInPassword password,
  });
}
