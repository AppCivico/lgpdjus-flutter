import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';

abstract class IAuthenticationRepository {
  Future<String> getLoginUrl();
  Future<SessionEntity> authenticate();
}
