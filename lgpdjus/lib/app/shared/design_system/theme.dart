import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lgpdjus/app/shared/design_system/colors.dart';

abstract class ThemeFactory {
  abstract final Color primaryColor;

  Color get elevatedButtonColor => primaryColor;

  ThemeData of(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = GoogleFonts.rubikTextTheme(themeData.textTheme);

    return themeData.copyWith(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      appBarTheme: themeData.appBarTheme.copyWith(
        centerTitle: true,
        color: primaryColor,
      ),
      primaryIconTheme:
          themeData.primaryIconTheme.copyWith(color: Colors.white),
      primaryTextTheme: GoogleFonts.rubikTextTheme(themeData.primaryTextTheme),
      textTheme: textTheme.copyWith(
        headline6: textTheme.headline6?.copyWith(
            // color: primaryColor,
            ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: elevatedButtonColor,
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        primary: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      )),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: primaryColor,
      )),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: primaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }

  static ThemeFactory get main => MainThemeFactory();
}

class MainThemeFactory extends ThemeFactory {
  @override
  final Color primaryColor = DesignSystemColors.main;
}

class RedThemeFactory extends ThemeFactory {
  @override
  final Color primaryColor = DesignSystemColors.red;

  @override
  final Color elevatedButtonColor = Color.fromARGB(255, 60, 60, 59);
}

class OrangeThemeFactory extends ThemeFactory {
  @override
  final Color primaryColor = DesignSystemColors.orange;
}

class BlueThemeFactory extends ThemeFactory {
  @override
  final Color primaryColor = DesignSystemColors.blue;
}

class TutorialThemeFactory extends MainThemeFactory {
  @override
  ThemeData of(BuildContext context) {
    final themeData = super.of(context);
    final textTheme = themeData.textTheme;
    return themeData.copyWith(
      backgroundColor: Color(0xfffafdf5),
      buttonColor: Colors.black87,
      focusColor: Color(0xff3b3d3b),
      indicatorColor: Color(0xff666666),
      textTheme: textTheme.copyWith(
        headline6: textTheme.headline6?.copyWith(fontSize: 24),
        bodyText1: textTheme.bodyText1?.copyWith(fontSize: 18),
        bodyText2: textTheme.bodyText2?.copyWith(fontSize: 18),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          textStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          primary: Color(0xff4a4a47),
        ),
      ),
    );
  }
}

class OrangeTutorialThemeFactory extends TutorialThemeFactory {
  @override
  ThemeData of(BuildContext context) {
    final themeData = super.of(context);
    final textTheme = themeData.textTheme;
    return themeData.copyWith(
      backgroundColor: DesignSystemColors.orange,
      buttonColor: Colors.white70,
      focusColor: Color(0xfffefdf8),
      indicatorColor: Color(0xfffffefa),
      textTheme: textTheme.apply(bodyColor: Colors.white),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          textStyle: TextStyle(
            fontSize: 16.0,
          ),
          primary: Color(0xfffffefc),
          side: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
