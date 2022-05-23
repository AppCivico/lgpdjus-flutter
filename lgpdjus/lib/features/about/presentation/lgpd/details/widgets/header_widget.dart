import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget(this.tile);

  final HeaderTile tile;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HtmlWidget(tile.introduction),
        SizedBox(height: 16),
        ColoredBox(
          color: themeData.primaryColor,
          child: SizedBox(width: 145, height: 1),
        ),
        SizedBox(height: 16),
        HtmlWidget(tile.instruction),
        SizedBox(height: 16),
      ],
    );
  }
}
