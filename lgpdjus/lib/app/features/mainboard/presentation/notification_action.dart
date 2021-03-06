import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationAction extends StatelessWidget {
  final int counter;
  final void Function() resetCounter;

  const NotificationAction({
    Key? key,
    required this.counter,
    required this.resetCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Badge(
        child: Icon(Icons.notifications, size: 32),
        elevation: 0.0,
        position: _badgePosition(counter),
        showBadge: counter > 0,
        toAnimate: false,
        badgeContent: Text(
          counter > 99 ? "+99" : counter.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      onPressed: () async => _forwardNotification(),
    );
  }

  BadgePosition? _badgePosition(int counter) {
    if (counter < 10) {
      return BadgePosition(end: -4, top: -8);
    } else if (counter < 100) {
      return BadgePosition(end: -8, top: -8);
    }

    return null;
  }

  void _forwardNotification() {
    resetCounter();
    Modular.to.pushNamed('/mainboard/notifications');
  }
}
