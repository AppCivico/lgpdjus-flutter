import 'package:equatable/equatable.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';

class NotificationSessionEntity extends Equatable {
  final bool hasMore;
  final String? nextPage;
  final List<NotificationEntity> notifications;

  NotificationSessionEntity({
    required this.hasMore,
    required this.nextPage,
    required this.notifications,
  });

  @override
  List<Object?> get props => [
        this.hasMore,
        this.nextPage,
        this.notifications,
      ];

  @override
  bool get stringify => true;
}

class NotificationEntity extends Actionable {
  final DateTime time;
  final Uri icon;
  final String title;
  final String content;
  @override
  final NavData? action;

  NotificationEntity({
    required this.content,
    required this.icon,
    required this.time,
    required this.title,
    this.action,
  });

  @override
  List<Object?> get props => [content, icon, time, title, ...super.props];

  @override
  bool get stringify => true;
}
