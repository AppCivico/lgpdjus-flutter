import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/features/notification/domain/entities/notification_session_entity.dart';

class NotificationSessionModel extends NotificationSessionEntity {
  NotificationSessionModel({
    required bool hasMore,
    required String? nextPage,
    required List<NotificationEntity> notifications,
  }) : super(
          hasMore: hasMore,
          nextPage: nextPage,
          notifications: notifications,
        );

  factory NotificationSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final hasMore = jsonData["has_more"] == 1;
    final nextPage = jsonData["next_page"];
    final jsonRows = jsonData["rows"] as List<dynamic>;
    final notifications = jsonRows.map((e) => _Parse.fromJson(e)).toList();

    return NotificationSessionModel(
      hasMore: hasMore,
      nextPage: nextPage,
      notifications: notifications,
    );
  }
}

extension _Parse on NotificationEntity {
  static NotificationEntity fromJson(Map<String, dynamic> jsonData) {
    final content = jsonData["content"];
    final icon = Uri(path: 'assets/images/svg/notification.svg');
    final title = jsonData["title"];
    final time = DateTime.parse(jsonData["time"]);

    final route = jsonData['expand_screen'];
    NavData? action;
    if (route != null) {
      action = NavData(route);
    }

    return NotificationEntity(
      content: content,
      icon: icon,
      title: title,
      time: time,
      action: action,
    );
  }
}
