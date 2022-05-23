import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';

class FooterWidget extends StatelessWidget {
  FooterWidget(this.tile);

  final FooterTile tile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: HtmlWidget(tile.content),
    );
  }

}