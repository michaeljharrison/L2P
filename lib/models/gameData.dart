import 'package:flutter/material.dart';

class GameData {
  // Fields
  String title;
  String description;
  List<String> tags;
  Color accent;

  GameData(String title, String description, Color accent)
      : this.title = title,
        this.description = description,
        this.accent = accent;
}
