import 'package:flutter/material.dart';

/// Default Theme for the application.
final ThemeData defaultTheme = ThemeData(
    // Colors
    brightness: Brightness.dark,
    primaryColor: Colors.grey[100],
    accentColor: Colors.blueAccent,
    // Fonts
    fontFamily: 'Montserrat');

/// Special Text Style for Game Title.
final TextStyle titleStyle = TextStyle(
  color: Colors.blueGrey[900],
  fontWeight: FontWeight.w900,
  fontSize: 34,
);
