import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';

class SessionModel extends SessionEntity {
  SessionModel({
    required String sessionToken,
    required bool deletedScheduled,
  }) : super(
          sessionToken: sessionToken,
          deletedScheduled: deletedScheduled,
        );

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
        sessionToken: json['session'],
        deletedScheduled: json['account_disabled'] == 1);
  }
}
