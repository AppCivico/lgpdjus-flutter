import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:lgpdjus/core/di/widget_module.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';
import 'package:lgpdjus/features/quiz/presentation/quiz_controller.dart';
import 'package:lgpdjus/features/quiz/presentation/widgets/quiz_divider.dart';

class CheckboxTileWidget extends StatefulWidget {
  CheckboxTileWidget(this.checkbox, {Key? key})
      : super(key: key ?? ValueKey(checkbox));

  final CheckboxTile checkbox;

  @override
  _CheckboxTileWidgetState createState() => _CheckboxTileWidgetState();
}

class _CheckboxTileWidgetState
    extends ModularWidgetState<CheckboxTileWidget, QuizReplyController> {
  final Set<String> _selectedValues = HashSet();

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
    return CheckboxListTile(
      onChanged: (v) => _onItemCheckedChange(option.value, v == true),
      value: _selectedValues.contains(option.value),
      contentPadding: EdgeInsets.zero,
      activeColor: Theme.of(context).primaryColor,
      title: Text(option.label),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  List<Widget> _buildChildren() {
    final Color dividerColor = Color(0xbf3c3c3b);
    final children = widget.checkbox.options.map((e) => _buildItem(e));

    return addDividers(
      children,
      dividerColor: dividerColor,
      thickness: 1,
    ).toList();
  }

  void _onItemCheckedChange(String itemValue, bool isChecked) {
    setState(() {
      if (isChecked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
      controller.answerValue = _selectedValues.join(",");
    });
  }
}
