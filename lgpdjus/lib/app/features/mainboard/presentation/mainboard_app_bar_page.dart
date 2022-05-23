import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lgpdjus/app/features/mainboard/presentation/notification_action.dart';
import 'package:lgpdjus/app/features/mainboard/presentation/notification_action_controller.dart';

class MainBoardAppBarPage extends StatefulWidget
    implements PreferredSizeWidget {
  const MainBoardAppBarPage({
    Key? key,
    this.instanceName = "| Tjsc",
  }) : super(key: key);

  final String instanceName;
  final String logo = "assets/images/svg/appbar/lgpdjus.svg";

  @override
  State<StatefulWidget> createState() => _MainBoardAppBarPageState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MainBoardAppBarPageState
    extends ModularState<MainBoardAppBarPage, NotificationActionController> {
  @override
  Widget build(BuildContext context) => Observer(builder: _buildAppBar);

  AppBar _buildAppBar(BuildContext context) {
    final themeData = Theme.of(context);

    final notificationAction = controller.state.map(
      anonymous: (_) => null,
      authenticated: (counter) => NotificationAction(
        resetCounter: () {},
        counter: counter.notificationCounter,
      ),
    );

    final actions = <Widget>[
      if (notificationAction != null) notificationAction,
      SizedBox(width: 4),
    ];

    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 24,
            width: 104,
            child: SvgPicture.asset(
              widget.logo,
              color: themeData.primaryIconTheme.color,
            ),
          ),
          Text(
            widget.instanceName.toUpperCase(),
            style: themeData.primaryTextTheme.headline6,
          ),
        ],
      ),
      actions: actions,
    );
  }
}
