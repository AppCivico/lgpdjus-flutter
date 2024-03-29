import 'package:flutter/material.dart';

class DesignSystemColors {
  static const main = Color.fromARGB(255, 166, 206, 57);
  static const red = Color.fromARGB(255, 214, 73, 51);
  static const orange = Color.fromARGB(255, 206, 126, 57);
  static const blue = Color.fromARGB(255, 57, 143, 206);

  // TODO: Fix color names bellow
  static const blue1 = main;
  static const blue2 = Color.fromRGBO(48, 120, 222, 1);
  static const blueGov = Color.fromRGBO(19, 81, 180, 1);
  static const blueHomeGradient = Color.fromRGBO(48, 100, 200, 1);
  static const darkIndigo = Color.fromRGBO(8, 8, 40, 1);
  static const textLink = Color(0xBF3C3C3B);
  static const darkIndigoTwo = Color.fromRGBO(16, 14, 87, 1);
  static const darkIndigoThree = Color.fromRGBO(10, 17, 95, 1);
  static const cobalt = Color.fromRGBO(27, 24, 106, 1);
  static const cobaltTwo = Color.fromRGBO(34, 29, 116, 1);
  static const twilight = Color.fromRGBO(85, 82, 156, 1);
  static const charcoalGrey = Color.fromRGBO(48, 54, 62, 1);
  static const charcoalGrey2 = Color.fromRGBO(68, 74, 83, 1);
  static const blueyGrey = Color.fromRGBO(141, 146, 157, 1);
  static const warnGrey = Color.fromRGBO(129, 129, 129, 1);
  static const brownishGrey = Color.fromRGBO(105, 105, 105, 1);
  static const white = Color.fromRGBO(252, 252, 252, 1);
  static const blueishGrey = Color.fromRGBO(181, 204, 217, 1);
  static const pinky = Color.fromRGBO(249, 130, 180, 1);
  static const pumpkinOrange = Color.fromRGBO(255, 130, 0, 1);
  static const helpCenterBackGround = Color.fromRGBO(10, 15, 95, 1);
  static const buttonBarIconColor = Color.fromRGBO(118, 118, 118, 1);
  static const buttonBarIconColorSelected = Color.fromRGBO(10, 17, 96, 1);
  static const helpCenterButtonBar = Color.fromRGBO(34, 29, 116, 1);
  static const helpCenterNavigationBar = Color.fromRGBO(33, 29, 116, 1);
  static const nigthBlue = Color.fromRGBO(5, 8, 70, 1);
  static const bluishPurple = Color.fromRGBO(129, 51, 255, 1);
  static const systemBackgroundColor = Color.fromRGBO(248, 248, 248, 1);
  static const doJus = Color(0xFFA6CE39);
  static const black = Color(0xFF3C3C3B);

  static Color hexColor(String value) {
    var hexColor = value.replaceFirst("#", "");
    if (hexColor.length == 6) {
      hexColor = "ff" + hexColor;
    }
    final intColor = int.tryParse(hexColor, radix: 16);

    return intColor != null ? Color(intColor) : Colors.transparent;
  }
}
