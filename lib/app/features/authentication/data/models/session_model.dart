import 'package:lgpdjus/app/features/authentication/domain/entities/session_entity.dart';

class SessionModel extends SessionEntity {
  SessionModel({
    required this.token,
    required this.logoutUrl,
    required bool deletedScheduled,
  }) : super(deletedScheduled: deletedScheduled);

  final String logoutUrl;
  final String token;

  @override
  List<Object?> get props => [token, logoutUrl, deletedScheduled];

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        token: json['session'],
        logoutUrl: json['logout_url'],
        deletedScheduled: json['account_disabled'] == 1,
      );
}
