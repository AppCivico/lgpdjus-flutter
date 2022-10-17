import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lgpdjus/app/core/pages/image_resolver_widget.dart';
import 'package:lgpdjus/common/navigation/action_handler.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/notification/domain/entities/notification_session_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key, required this.notification})
      : super(key: key);

  final NotificationEntity notification;

  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  NotificationEntity get notification => widget.notification;
  late final actionHandler = inject<ActionHandler>();

  VoidCallback? get _onTap {
    if (notification.action == null) return null;
    return () => actionHandler.handle(notification);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: themeData.primaryColor,
          ),
        ),
      ),
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.0),
                child: ImageResolverWidget(
                  notification.icon,
                  color: themeData.primaryColor,
                  height: 24,
                  width: 24,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: themeData.textTheme.headline6,
                      ),
                      Text(
                        timeago.format(notification.time, locale: 'pt_br'),
                        style: themeData.textTheme.caption,
                      ),
                      _notificationContent(themeData, notification.content),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationContent(ThemeData themeData, String? content) {
    if (content?.isEmpty ?? true) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: HtmlWidget(
        notification.content,
        webViewJs: false,
        textStyle: themeData.textTheme.bodyText1!.copyWith(
          color: Color(0xFF3C3C3B),
        ),
      ),
    );
  }
}
