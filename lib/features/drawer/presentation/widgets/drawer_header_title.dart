import 'package:flutter/material.dart';
import 'package:lgpdjus/features/drawer/presentation/widgets/account_badge.dart';

class DrawerHeaderTitle extends StatelessWidget {
  DrawerHeaderTitle({required this.title, required this.status, this.padding});

  final EdgeInsetsGeometry? padding;

  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: textTheme.headline6?.copyWith(fontSize: 18),
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
          Flexible(child: AccountBadge(status)),
        ],
      ),
    );
  }
}
