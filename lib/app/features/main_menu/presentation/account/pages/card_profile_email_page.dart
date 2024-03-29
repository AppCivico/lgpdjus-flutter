import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';

import 'card_profile_header_edit_page.dart';

class CardProfileEmailPage extends StatelessWidget {
  final String content;
  final void Function(String newEmail) onChange;

  const CardProfileEmailPage({
    Key? key,
    required this.content,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignSystemColors.systemBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfileHeaderEditPage(
              title: "Email",
              onEditAction: () => showModal(context: context),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 20.0),
              child: Text(
                content,
                style: contentTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension _Modal on CardProfileEmailPage {
  void showModal({required BuildContext context}) {
    TextEditingController emailController = TextEditingController();

    asuka.showDialog(
      builder: (context) => AlertDialog(
        title: Text('Email'),
        scrollable: true,
        content: Column(
          children: [
            TextFormField(
              maxLines: 1,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Digite o novo email', filled: true),
            ),
            SizedBox(height: 20),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Enviar'),
            onPressed: () async {
              onChange(emailController.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

extension _TextStyle on CardProfileEmailPage {
  TextStyle get contentTextStyle => TextStyle(
        fontSize: 14.0,
      );
}
