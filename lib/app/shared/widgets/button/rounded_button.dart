import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/theme.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 40,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialButton(
      height: size,
      color: theme.primaryColor,
      onPressed: onPressed,
      shape: CircleBorder(),
      padding: EdgeInsets.only(left: 2),
      child: Icon(
        icon,
        size: 24,
        color: theme.primaryIconTheme.color,
      ),
    );
  }
}
