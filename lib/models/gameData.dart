import 'package:L2P/components/guideSection.dart';
import 'package:flutter/material.dart';

class GameData {
  // Fields
  String title;
  String description;
  Color accent;
  List<String> tags;
  List<GuideSection> guideSections;

  GameData(String title, String description, Color accent, List<String> tags,
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
