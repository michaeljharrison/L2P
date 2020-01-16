import 'package:L2P/components/guideSection.dart';
import 'package:flutter/material.dart';

class Game {
  // Fields
  String title;
  String description;
  Color accent;
  List<String> tags;
  List<GuideSection> guideSections;

  Game(String title, String description, Color accent, List<String> tags,
      List<GuideSection> guideSections)
      : this.title = title,
        this.description = description,
        this.tags = tags,
        this.accent = accent,
        this.guideSections = guideSections;

  void setGuideSections(List<GuideSection> sections) {
    this.guideSections = sections;
  }
}
