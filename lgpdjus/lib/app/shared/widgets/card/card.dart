import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/dimens.dart';

final cardBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(DesignSystemDimens.cardRadius),
);

class RoundedCard extends Card {
  RoundedCard({
    ShapeBorder? shape,
    double? elevation,
    EdgeInsetsGeometry? margin,
    required Widget child,
  }) : super(
          shape: shape ?? cardBorder,
          elevation: elevation ?? DesignSystemDimens.cardElevation,
          margin: margin,
          child: child,
        );
}
