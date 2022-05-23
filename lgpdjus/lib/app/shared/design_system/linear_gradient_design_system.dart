import 'package:flutter/widgets.dart';

const kLinearGradientDesignSystem = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0.0,
      0.5,
      1.0,
    ],
    colors: [
      Color(0xFFFFFCF8),
      Color(0xFFFCFFF5),
      Color(0xFFFFFCF8),
    ],
  ),
);
