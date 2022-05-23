import 'package:flutter/material.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';
import 'package:lgpdjus/app/shared/design_system/text_styles.dart';

String? _normalizeHitText(String? text) {
  if (text == null || text.isEmpty) {
    return null;
  }

  return text;
}

class WhiteBoxDecorationStyle extends InputDecoration {
  WhiteBoxDecorationStyle({
    String? labelText,
    String? hintText,
    String? errorText,
  }) : super(
          border: OutlineInputBorder(),
          labelText: labelText,
          labelStyle: kTextStyleDefaultTextFieldLabelStyle,
          hintText: hintText,
          hintStyle: kTextStyleDefaultTextFieldLabelStyle,
          errorText: _normalizeHitText(errorText),
          contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DesignSystemColors.doJus),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DesignSystemColors.doJus),
          ),
        );
}

class PurpleBoxDecorationStyle extends InputDecoration {
  PurpleBoxDecorationStyle({
    required String labelText,
    required String hintText,
    required String errorText,
  }) : super(
          border: OutlineInputBorder(),
          labelText: labelText,
          labelStyle: kTextStyleGreyDefaultTextFieldLabelStyle,
          hintText: hintText,
          hintStyle: kTextStyleGreyDefaultTextFieldLabelStyle,
          errorText: _normalizeHitText(errorText),
          contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DesignSystemColors.blue2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DesignSystemColors.blue2),
          ),
        );
}
