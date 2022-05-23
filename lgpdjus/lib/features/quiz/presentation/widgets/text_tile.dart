import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lgpdjus/features/quiz/domain/entity.dart';

class TextTileWidget extends StatelessWidget {
  const TextTileWidget(this.textTile, {Key? key}) : super(key: key);

  final TextTile textTile;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(top: textTile.marginTop),
        padding: EdgeInsets.only(bottom: 24),
        width: double.infinity,
        child: HtmlWidget(textTile.text),
      ),
    );
  }
}
