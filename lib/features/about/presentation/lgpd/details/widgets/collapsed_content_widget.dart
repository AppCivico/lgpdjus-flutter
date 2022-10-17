import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lgpdjus/features/about/domain/entity/details_screen.dart';

class CollapsedContentWidget extends StatefulWidget {
  CollapsedContentWidget(this.tile);

  final CollapsedContentTile tile;

  @override
  State<StatefulWidget> createState() => _CollapsedContentWidgetState();
}

class _CollapsedContentWidgetState extends State<CollapsedContentWidget> {
  @override
  Widget build(BuildContext context) {
    final boxRadius = const BorderRadius.all(const Radius.circular(10));
    final themeData = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        boxShadow: _boxShadow(),
        borderRadius: boxRadius,
        color: Colors.white,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        iconColor: themeData.primaryColor,
        collapsedIconColor: themeData.primaryColor,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.tile.title,
          textAlign: TextAlign.start,
          style: themeData.textTheme.headline6
              ?.copyWith(color: themeData.primaryColor),
        ),
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: EdgeInsets.only(bottom: 8),
            child: HtmlWidget(widget.tile.content),
          ),
        ],
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
