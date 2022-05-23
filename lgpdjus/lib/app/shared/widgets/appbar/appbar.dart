import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThemedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ThemedAppBar({
    Key? key,
    this.leading,
    this.title,
    this.instanceName = " | Tjsc",
  })  : super(key: key);

  final Widget? leading;
  final String? title;
  final String instanceName;
  final String logo = "assets/images/svg/appbar/lgpdjus.svg";

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.primaryColor,
      leading: leading,
      titleSpacing: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              title ?? "",
              style: theme.primaryTextTheme.subtitle1,
              maxLines: 2,
            ),
          ),
          SizedBox(width: 16),
          SizedBox(
            height: 18,
            width: 70,
            child: SvgPicture.asset(
              logo,
              color: theme.primaryIconTheme.color,
            ),
          ),
          Text(
            instanceName.toUpperCase(),
            style: theme.primaryTextTheme.subtitle1?.copyWith(
              fontSize: 18,
            ),
          ),
          SizedBox(width: 16)
        ],
      ),
    );
  }
}
