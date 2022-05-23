import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';

class LoginButton extends StatefulWidget {
  final void Function() onChanged;

  // final void Function() _onChanged;

  LoginButton({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 44,
        child: RaisedButton(
          onPressed: widget.onChanged,
          elevation: 0,
          color: DesignSystemColors.doJus,
          child: Text(
            'Entrar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
      ),
    );
  }
}
