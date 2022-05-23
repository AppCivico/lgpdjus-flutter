import 'package:flutter/material.dart';

class BackgroundDecoration extends BoxDecoration {
  BackgroundDecoration(Color middle)
      : super(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xfffffcf8),
              middle,
              Color(0xfffffcf8),
            ],
            tileMode: TileMode.clamp,
          ),
        );

  factory BackgroundDecoration.main() =>
      BackgroundDecoration(Color(0xfffcfff5));

  factory BackgroundDecoration.red() => BackgroundDecoration(Color(0xfffff3e6));

  factory BackgroundDecoration.orange() =>
      BackgroundDecoration(Color(0xfffff3e6));
}
