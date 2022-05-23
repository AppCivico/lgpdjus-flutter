import 'package:flutter/material.dart';
import 'package:lgpdjus/features/about/domain/entity/topics_screen.dart';

class SectionTitleWidget extends StatelessWidget {
  SectionTitleWidget(this.tile);

  final SectionTitleTile tile;

  @override
  Widget build(BuildContext context) {
    final boxRadius = const BorderRadius.all(const Radius.circular(10));
    final themeData = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        boxShadow: _boxShadow(),
        borderRadius: boxRadius,
        color: themeData.primaryColor,
      ),
      child: Text(
        tile.content,
        textAlign: TextAlign.center,
        style: themeData
            .textTheme
            .headline6
            ?.copyWith(color: Colors.white),
      ),
    );
  }

  List<BoxShadow> _boxShadow() {
    return const [
      const BoxShadow(
        color: Color(0x29000000),
        offset: Offset(0, 3),
        blurRadius: 6,
      ),
    ];
  }
}
