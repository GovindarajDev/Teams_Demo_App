import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    backgroundColor: Colors.white,
    cardColor: bgTextFormFieldColor,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      centerTitle: false
    ),
    cardTheme: const CardTheme(color: Colors.white),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: primaryColor,
            onPrimary: primaryColor,
            secondary: primaryColor,
            onSecondary: primaryColor,
            error: primaryColor,
            onError: primaryColor,
            background: primaryColor,
            onBackground: primaryColor,
            surface: primaryColor,
            onSurface: primaryColor)),
    colorScheme: const ColorScheme.light(
      // primary: bgTextFormFieldColor,
      background: scaffoldBackgroundColor,
      secondary: bgTextFormFieldColor,

    ),
    iconTheme: const IconThemeData(color: iconColor),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.black,
      ),
      headline2: TextStyle(
        color: txtLightColor,
      ),
       headline3: TextStyle(
          color: Colors.black,
        ),
      button: TextStyle(color: Colors.white),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.black,
    cardColor: bottomBackColor,
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      centerTitle: false
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bottomBackColor,
    ),
    cardTheme: const CardTheme(color: bottomBackColor),
    buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: primaryColor,
            onPrimary: primaryColor,
            secondary: primaryColor,
            onSecondary: primaryColor,
            error: primaryColor,
            onError: primaryColor,
            background: primaryColor,
            onBackground: primaryColor,
            surface: primaryColor,
            onSurface: primaryColor)),
    expansionTileTheme: const ExpansionTileThemeData(
      backgroundColor: bottomBackColor,
      iconColor: primaryColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    colorScheme: const ColorScheme.dark(
      background: bottomBackColor,
      secondary: Colors.black,
      // primary: bottomBackColor
    ),
    iconTheme: const IconThemeData(color: iconColor),
    textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.white,
        ),
        headline2: TextStyle(
          color: Colors.white38,
        ),
        headline3: TextStyle(
          color: Colors.black,
        ),
        button: TextStyle(color: Colors.white)),
  );
}

// colors
const Color primaryColor = Color(0xff0CABDF);
const Color iconColor = Color(0xff76808A);
const Color bottomBackColor = Color(0xff161618);
const Color txtLightColor = Color(0xff75808A);
const Color txtDarkColor = Color(0xff000000);
const Color bgNameCardColor = Color(0xff1A62C6);
const Color bgTextFormFieldColor = Color(0xffE9EEF0);
const Color bgTxtColor = Color(0xffC6EBF6);
const Color bgInvitedNameCardColor = Color(0xffAC816E);

const Color scaffoldBackgroundColor = Color(0xffF7F7F7);
