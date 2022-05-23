import 'package:flutter/material.dart';

typedef SeparatedWidgetsBuilder = List<Widget> Function(List<Widget>, Widget);

Iterable<Widget> addDividers(
  Iterable<Widget> widgets, {
  required Color dividerColor,
  EdgeInsetsGeometry margin: EdgeInsets.zero,
  double? thickness: 2.0,
}) {
  final divider = Container(
    margin: margin,
    child: Divider(
      thickness: thickness,
      color: dividerColor,
      height: 0,
    ),
  );
  return widgets.fold<List<Widget>>([], _dividerBuilder(divider)).toList();
}

SeparatedWidgetsBuilder _dividerBuilder(Widget divider) {
  return (List<Widget> previousValue, Widget element) {
    if (previousValue.isEmpty) return [element];
    return previousValue + [divider, element];
  };
}
