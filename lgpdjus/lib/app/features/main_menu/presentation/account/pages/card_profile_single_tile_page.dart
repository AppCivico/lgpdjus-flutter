import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';

import 'card_profile_header_edit_page.dart';

class CardProfileSingleTilePage extends StatelessWidget {
  final String title;
  final String content;
  final Color? background;

  const CardProfileSingleTilePage({
    Key? key,
    required this.title,
    required this.content,
    this.background = DesignSystemColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background ?? DesignSystemColors.white,
        border: Border(
          bottom: BorderSide(
            color: background == DesignSystemColors.white
                ? DesignSystemColors.blueishGrey
                : background!,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfileHeaderEditPage(title: title, onEditAction: null),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
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

extension _TextStyle on CardProfileSingleTilePage {
  TextStyle get contentTextStyle => TextStyle(
        fontSize: 14.0,
      );
}
