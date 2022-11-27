import 'package:asuka/asuka.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lgpdjus/app/core/extension/iterable.dart';
import 'package:lgpdjus/common/domain/titles/entity.dart';
import 'package:lgpdjus/common/navigation/action_handler.dart';
import 'package:lgpdjus/core/di/widget_module.dart';

mixin DialogHandler {
  late final ActionHandler _actionHandler = inject();

  void handleAction(ActionData action) {
    _actionHandler.navigate(action);
  }

  void showDialog(DialogData dialog) => showAlertDialog(
        dialog.title,
        dialog.content,
        dialog.primaryAction,
        dialog.secondaryAction,
      );

  void maybeShowDialog(DialogData? dialog) {
    if (dialog != null) {
      showDialog(dialog);
    }
  }

  Future showAlertDialog(
    String title,
    String content,
    NamedAction primaryAction, [
    NamedAction? secondaryAction,
  ]) {
    return Asuka.showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black38,
      builder: (context) {
        final themeData = Theme.of(context);
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: themeData.textTheme.headline6
                ?.copyWith(color: themeData.primaryColor),
          ),
          content: Text(content, textAlign: TextAlign.center),
          actions: _buildActions(context, primaryAction, secondaryAction),
        );
      },
    );
  }

  List<Widget> _buildActions(
    BuildContext context,
    NamedAction primaryAction,
    NamedAction? secondaryAction,
  ) {
    final actions = listOfNotNull([
      _buildSecondaryAction(context, secondaryAction),
      SizedBox(width: 8),
      _buildPrimaryAction(context, primaryAction),
    ]);

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: actions,
      )
    ];
  }

  Widget _buildPrimaryAction(BuildContext context, NamedAction primaryAction) {
    return ElevatedButton(
      child: Text(primaryAction.name),
      onPressed: () {
        _onButtonPressed(context, primaryAction.action);
      },
    );
  }

  Widget? _buildSecondaryAction(
      BuildContext context, NamedAction? secondaryAction) {
    if (secondaryAction == null) return null;
    return OutlinedButton(
      child: Text(secondaryAction.name),
      onPressed: () {
        _onButtonPressed(context, secondaryAction.action);
      },
    );
  }

  _onButtonPressed(BuildContext context, ActionData? action) {
    if (action != null) handleAction(action);
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class DialogData extends Equatable {
  DialogData(
    this.title,
    this.content,
    this.primaryAction, [
    this.secondaryAction,
  ]);

  final String title;
  final String content;
  final NamedAction primaryAction;
  final NamedAction? secondaryAction;

  @override
  List<Object?> get props => [title, content, primaryAction, secondaryAction];
}
