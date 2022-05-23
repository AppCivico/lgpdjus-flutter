import 'package:flutter/material.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/presentation/quiz_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CpfEditTextTileWidget extends StatefulWidget {
  CpfEditTextTileWidget(this.editText, {Key? key})
      : super(key: key ?? ValueKey(editText));

  final EditTextTile editText;

  @override
  _CpfEditTextTileWidgetState createState() => _CpfEditTextTileWidgetState();
}

class _CpfEditTextTileWidgetState
    extends ModularWidgetState<CpfEditTextTileWidget, QuizReplyController> {
  final _mask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'\d')},
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      constraints: BoxConstraints(maxHeight: 200),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Escreva aqui',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [_mask],
        maxLines: 1,
        onChanged: (v) => _onTextChanged(v),
      ),
    );
  }

  void _onTextChanged(String text) {
    setState(() {
      final value = text.replaceAll(RegExp(r'\D'), '');
      controller.answerValue = value;
    });
  }
}
