import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:lgpdjus/app/features/main_menu/presentation/account/pages/card_profile_header_edit_page.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';

class CardProfileNamePage extends StatelessWidget {
  final String name;
  final void Function(String) onChange;

  const CardProfileNamePage({
    Key? key,
    required this.name,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: Column(
          children: [
            CardProfileHeaderEditPage(
              title: "Como deseja ser chamado?",
              onEditAction: () => showModal(context: context),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 20.0),
              child: Row(
                children: [
                  Text(name, style: nameTextStyle),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension _TextStyle on CardProfileNamePage {
  TextStyle get nameTextStyle => TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      );
}

extension _Dialog on CardProfileNamePage {
  void showModal({required BuildContext context}) {
    TextEditingController _controller = TextEditingController();
    _controller.text = name;

    asuka.showDialog(
      builder: (context) => AlertDialog(
        title: Text('Editar'),
        content: TextFormField(
          controller: _controller,
          maxLines: 1,
          decoration: InputDecoration(
              hintText: 'Digite o novo endereçamento', filled: true),
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
              onChange(_controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
