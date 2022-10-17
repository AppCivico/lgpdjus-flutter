import 'package:flutter/material.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/presentation/quiz_controller.dart';

class EditTextTileWidget extends StatefulWidget {
  EditTextTileWidget(this.editText, {Key? key})
      : super(key: key ?? ValueKey(editText));

  final EditTextTile editText;

  @override
  _EditTextTileWidgetState createState() => _EditTextTileWidgetState();
}

class _EditTextTileWidgetState
    extends ModularWidgetState<EditTextTileWidget, QuizReplyController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      constraints: BoxConstraints(maxHeight: 200),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Escreva aqui',
        ),
        maxLines: null,
        onChanged: (v) => _onTextChanged(v),
      ),
    );
  }

  void _onTextChanged(String text) {
    setState(() {
      controller.answerValue = text;
    });
  }
}
