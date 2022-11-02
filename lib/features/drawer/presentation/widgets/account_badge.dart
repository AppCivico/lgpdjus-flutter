import 'package:flutter/material.dart';

class AccountBadge extends StatelessWidget {
  AccountBadge(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final badgeRadius = Radius.circular(10);

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0x80FFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: badgeRadius,
          bottomLeft: badgeRadius,
          bottomRight: badgeRadius,
        ),
      ),
      child: Text(
        status,
        style: textTheme.caption?.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
