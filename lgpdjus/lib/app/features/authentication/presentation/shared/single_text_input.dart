import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';

class SingleTextInput extends StatefulWidget {
  final TextInputType keyboardType;
  final TextStyle style;
  final void Function(String) onChanged;
  final List<TextInputFormatter> inputFormatters = [];
  final InputDecoration boxDecoration;
  final String? value;

  SingleTextInput({
    Key? key,
    TextInputFormatter? inputFormatter,
    this.keyboardType = TextInputType.text,
    this.style = kTextStyleDefaultTextFieldStyle,
    required this.onChanged,
    required this.boxDecoration,
    this.value,
  }) : super(key: key) {
    if (inputFormatter != null) {
      this.inputFormatters.add(inputFormatter);
    }
  }

  @override
  State<StatefulWidget> createState() => _SingleTextInputState();
}

class _SingleTextInputState extends State<SingleTextInput> {
  late final _controller = TextEditingController(text: widget.value);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onChanged(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: widget.style,
      controller: _controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      autofocus: false,
      decoration: widget.boxDecoration,
    );
  }
}
