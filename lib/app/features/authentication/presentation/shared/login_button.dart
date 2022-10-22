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
        width: double.infinity,
        child: RaisedButton(
          onPressed: widget.onChanged,
          elevation: 0,
          color: DesignSystemColors.blue2,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              children: [
                TextSpan(text: 'Entrar com '),
                TextSpan(
                  text: 'gov.br',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
