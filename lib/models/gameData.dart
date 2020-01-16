import 'dart:developer';

import 'package:L2P/components/guideSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GameData {
  // Fields
  String title;
  String description;
  String coverLocation;
  Color accent;
  List<String> tags;
  List<GuideSection> guideSections;
  CollectionReference guidesRef;

  GameData({
    String title,
    String description,
    String coverLocation,
    Color accent,
    List<String> tags,
    List<GuideSection> guideSections,
  })  : this.title = title,
        this.description = description,
        this.tags = tags,
        this.coverLocation = coverLocation,
        this.accent = accent,
        this.guideSections = guideSections;

  void setGuideSections(List<GuideSection> sections) {
    this.guideSections = sections;
  }

  static GameData fromSnapshot(DocumentSnapshot snapshot) {
    String titlePath = snapshot.data['title'].replaceAll(' ', '_');
    List<GuideSection> guideList = new List<GuideSection>();
    snapshot.reference.collection('guides').getDocuments().then((guides) {
      guides.documents.forEach((guideDoc) {
        guideDoc.data.forEach((key, value) {
          log('$key = $value');
        });
        guideList.add(new GuideSection(
            title: guideDoc['title'],
            description: guideDoc['description'],
            ordered: guideDoc['ordered'],
            buttonTitles: <String>[]));
      });
    });

    return new GameData(
      title: snapshot.data['title'],
      description: snapshot.data['description'],
      accent: Color.fromRGBO(snapshot.data['accent'][0],
          snapshot.data['accent'][1], snapshot.data['accent'][2], 1),
      tags: List<String>.from(snapshot.data['tags']),
      coverLocation: 'assets/images/covers/$titlePath.png',
      guideSections: guideList,
    );
  }
}
