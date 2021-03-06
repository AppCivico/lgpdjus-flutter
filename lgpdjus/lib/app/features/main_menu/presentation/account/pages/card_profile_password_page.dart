import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';

import 'card_profile_header_edit_page.dart';

class CardProfilePasswordPage extends StatelessWidget {
  final String content;
  final void Function(String, String) onChange;

  const CardProfilePasswordPage({
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
              title: "Senha",
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

extension _Modal on CardProfilePasswordPage {
  void showModal({required BuildContext context}) {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController oldPasswordController = TextEditingController();

    asuka.showDialog(
      builder: (context) => AlertDialog(
        title: Text('Email'),
        scrollable: true,
        content: Column(
          children: [
            TextFormField(
              maxLines: 1,
              autocorrect: false,
              keyboardType: TextInputType.text,
              controller: newPasswordController,
              decoration: InputDecoration(
                  hintText: 'Digite a nova senha', filled: true),
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 1,
              autocorrect: false,
              keyboardType: TextInputType.text,
              controller: oldPasswordController,
              decoration: InputDecoration(
                  hintText: 'Digite a senha atual', filled: true),
            ),
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
              onChange(
                newPasswordController.text,
                oldPasswordController.text,
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

extension _TextStyle on CardProfilePasswordPage {
  TextStyle get contentTextStyle => TextStyle(
        fontSize: 14.0,
      );
}
