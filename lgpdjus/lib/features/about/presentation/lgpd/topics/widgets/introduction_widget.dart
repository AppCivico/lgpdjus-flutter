import 'package:flutter/material.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';

class IntroductionWidget extends StatelessWidget {
  IntroductionWidget(this.tile);

  final IntroductionTile tile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24),
      child: Text(
        tile.content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
