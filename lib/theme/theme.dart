import 'package:flutter/material.dart';

final colorBGLight = new Color.fromRGBO(42, 58, 72, 1);
final colorBGDark = new Color.fromRGBO(26, 34, 42, 1);
final colorTealPrimary = new Color.fromRGBO(101, 212, 186, 1);
final colorTealDark = new Color.fromRGBO(96, 142, 172, 1);
final colorTagBlue = new Color.fromRGBO(0, 168, 221, 1);
final colorTagTeal = new Color.fromRGBO(101, 212, 186, 1);

/// THEMES
/// Default Theme for the application.
final ThemeData themeDefault = ThemeData(
    // Colors
    brightness: Brightness.dark,
    primaryColor: colorBGLight,
    accentColor: colorTealPrimary,
    dividerColor: colorTealDark,
    textTheme: new TextTheme(
        title: TextStyle(
          color: colorTealPrimary,
          fontWeight: FontWeight.w300,
          fontSize: 34,
        ),
        subtitle: TextStyle(
          color: colorTealPrimary,
          fontWeight: FontWeight.w300,
          fontSize: 26,
        ),
        headline: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        //subhead: ,
        body1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 12,
          height: 1.5,
        ),
        //body2: ,
        button: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 10,
        )),
    // Fonts
    fontFamily: 'Montserrat');

/// TEXT STYLES
/// Special Text Style for Splash Screen
final TextStyle textStyleSplashTitle = TextStyle(
  color: colorTealPrimary,
  fontWeight: FontWeight.w300,
  fontSize: 48,
);
