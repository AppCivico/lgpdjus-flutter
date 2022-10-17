import 'package:flutter/material.dart';

class SpaceSpan extends TextSpan {
  SpaceSpan([double height = 1])
      : super(
          text: '\n0x00A0\n',
          style: TextStyle(fontSize: 2, height: height),
        );

  factory SpaceSpan.br() => SpaceSpan(2);

  factory SpaceSpan.paragraph() => SpaceSpan(5);
}
