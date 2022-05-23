import 'package:flutter/material.dart';
import 'package:lgpdjus/common/navigation/action_handler.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';

class LinkButtonWidget extends StatelessWidget {
  LinkButtonWidget(this.tile) : super();

  final LinkButtonTile tile;
  late final ActionHandler _actionHandler = inject();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        tile.text,
        style: TextStyle(decoration: TextDecoration.underline),
      ),
      onPressed: () {
        _actionHandler.handle(tile);
      },
    );
  }
}
