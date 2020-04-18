import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

/// TODO: Make sure these colors match with the figma design.
final cardBG = new Color.fromRGBO(42, 58, 72, 1);
final systemBG = new Color.fromRGBO(26, 34, 42, 1);
final uiElement = new Color.fromRGBO(96, 142, 172, 1);
final buttonPrimary = new Color.fromRGBO(0, 168, 221, 1);
final buttonSecondary = new Color.fromRGBO(101, 212, 186, 1);
final progressIndicator = new Color.fromRGBO(02, 142, 172, 1);
final colorTagTeal = new Color.fromRGBO(101, 212, 186, 1);
final colorTabBar = new Color.fromRGBO(12, 17, 21, 1);
final colorBottomNav = new Color.fromRGBO(12, 17, 21, 0.8);

/// THEMES
/// Default Theme for the application.
final ThemeData themeDefault = ThemeData(
    // Colors
    brightness: Brightness.dark,
    primaryColor: cardBG,
    accentColor: buttonSecondary,
    dividerColor: uiElement,

    /// TODO: Make sure these match exactly with the figma design.
    textTheme: new TextTheme(
        display1: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        title: TextStyle(
          color: buttonSecondary,
          fontWeight: FontWeight.w300,
          fontSize: 34,
        ),
        subtitle: TextStyle(
          color: buttonSecondary,
          fontWeight: FontWeight.w300,
          fontSize: 26,
        ),
        headline: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        subhead: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
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
          fontSize: 14,
        )),
    // Fonts
    fontFamily: 'Montserrat');

final ExpandableThemeData expandableThemeDefault =
    ExpandableThemeData(iconColor: uiElement);

/// TEXT STYLES
/// Special Text Style for Splash Screen
final TextStyle textStyleSplashTitle = TextStyle(
  color: buttonSecondary,
  fontWeight: FontWeight.w300,
  fontSize: 48,
);
