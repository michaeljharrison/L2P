import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

/// TODO: Make sure these colors match with the figma design.
final cardBG = new Color.fromRGBO(42, 58, 72, 1);
final systemBG = new Color.fromRGBO(26, 34, 42, 1);
final uiElement = new Color.fromRGBO(96, 142, 172, 1);
final buttonPrimary = new Color.fromRGBO(0, 168, 221, 1);
final buttonSecondary = new Color.fromRGBO(101, 212, 186, 1);
final buttonTertiary = new Color.fromRGBO(180, 135, 201, 1);
final progressIndicator = new Color.fromRGBO(02, 142, 172, 1);
final colorTabBar = new Color.fromRGBO(12, 17, 21, 1);
final colorBottomNav = new Color.fromRGBO(12, 17, 21, 0.8);
final colorTransparent = new Color.fromRGBO(0, 0, 0, 0);
final Shader linearTransparentGradient = LinearGradient(
  colors: <Color>[Colors.white, Color.fromRGBO(255, 255, 255, 0)],
  begin: Alignment.center,
).createShader(Rect.fromCircle(
  center: Offset(20, -200),
  radius: 20 / 3,
));
final backgroundBlueGradient = new LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromRGBO(37, 90, 142, 1), Color.fromRGBO(16, 38, 61, 1)]);
final backgroundCardGradient = new LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(63, 84, 102, 1),
      Color.fromRGBO(54, 73, 89, 1),
      Color.fromRGBO(33, 45, 55, 1)
    ]);

/// THEMES
/// Default Theme for the application.
final ThemeData themeDefault = ThemeData(
    // Colors
    brightness: Brightness.dark,
    primaryColor: cardBG,
    backgroundColor: systemBG,
    accentColor: buttonSecondary,
    dividerColor: Colors.white,
    disabledColor: uiElement,

    /// TODO: Make sure these match exactly with the figma design.
    textTheme: new TextTheme(
      headline4: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
      headline6: TextStyle(
        color: buttonSecondary,
        fontWeight: FontWeight.w300,
        fontSize: 34,
      ),
      subtitle2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 16,
        height: 1.5,
      ),
      bodyText2: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 12,
          height: 1.5,
          fontFamily: 'Montserrat'),
      //body2: ,
      button: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      caption: TextStyle(color: buttonPrimary, fontSize: 14),
    ),
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
