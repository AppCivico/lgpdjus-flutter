import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';

class PasswordInputField extends StatefulWidget {
  final TextStyle style;
  final void Function(String) onChanged;
  final String labelText;
  final String errorText;
  final String? hintText;
  final String? value;

  PasswordInputField({
    Key? key,
    this.style = kTextStyleDefaultTextFieldStyle,
    required this.onChanged,
    required this.labelText,
    required this.errorText,
    this.hintText,
    this.value,
  }) : super(key: key);

  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  _PasswordInputFieldState();

  bool _isPasswordVisible = false;
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
      controller: _controller,
      style: widget.style,
      onChanged: widget.onChanged,
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: DesignSystemColors.doJus)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: DesignSystemColors.doJus)),
        border: OutlineInputBorder(),
        labelText: widget.labelText,
        labelStyle: kTextStyleDefaultTextFieldLabelStyle,
        hintText: widget.hintText,
        hintStyle: kTextStyleDefaultTextFieldLabelStyle,
        errorText: _normalizeHitText(widget.errorText),
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        suffixIcon: IconButton(
          icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColor),
          onPressed: _togglePassword,
        ),
      ),
    );
  }

  void _togglePassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  String? _normalizeHitText(String? text) {
    if (text == null || text.isEmpty) {
      return null;
    }

    return text;
  }
}
