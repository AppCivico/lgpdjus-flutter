import 'package:flutter/material.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/presentation/quiz_controller.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/quiz_divider.dart';

class RadioTileWidget extends StatefulWidget {
  RadioTileWidget(this.radio, {Key? key}) : super(key: key ?? ValueKey(radio));

  final RadioTile radio;

  @override
  _RadioTileWidgetState createState() => _RadioTileWidgetState();
}

class _RadioTileWidgetState
    extends ModularWidgetState<RadioTileWidget, QuizReplyController> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildChildren(),
        ),
      ),
    );
  }

  Widget _buildItem(Option option) {
    return RadioListTile(
      onChanged: (v) => _onItemCheckedChange(v.toString()),
      value: option.value,
      contentPadding: EdgeInsets.zero,
      groupValue: _selectedValue,
      activeColor: Theme.of(context).primaryColor,
      title: Text(option.label),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  List<Widget> _buildChildren() {
    final Color dividerColor = Color(0xbf3c3c3b);
    final children = widget.radio.options.map((e) => _buildItem(e));

    return addDividers(
      children,
      dividerColor: dividerColor,
      thickness: 1,
    ).toList();
  }

  void _onItemCheckedChange(String itemValue) {
    setState(() {
      _selectedValue = itemValue;
      controller.answerValue = itemValue;
    });
  }
}
