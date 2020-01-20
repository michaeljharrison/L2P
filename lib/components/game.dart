import 'dart:developer';

import 'package:L2P/components/guideSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Game {
  // Fields
  String title;
  String description;
  String coverLocation;
  Color accent;
  List<String> tags;
  List<GuideSection> guideSections;
  CollectionReference guidesRef;

  Game({
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

  static Game fromSnapshot(DocumentSnapshot snapshot) {
    String titlePath = snapshot.data['title'].replaceAll(' ', '_');
    List<GuideSection> guideSectionList = new List<GuideSection>();
    snapshot.reference
        .collection('sections')
        .getDocuments()
        .then((guideSections) {
      guideSections.documents.forEach((guideSection) {
        List<String> guideList = new List<String>();
        guideSection.reference
            .collection('guides')
            .getDocuments()
            .then((guides) {
          guides.documents.forEach((guide) {
            guideList.add(guide["title"]);
          });
        });

        guideSectionList.add(new GuideSection(
            title: guideSection['title'],
            description: guideSection['description'],
            ordered: guideSection['ordered'],
            order: guideSection['order'],
            buttonTitles: guideList));
      });
    });

    guideSectionList.sort(GuideSection.sortByOrder);

    return new Game(
      title: snapshot.data['title'],
      description: snapshot.data['description'],
      accent: Color.fromRGBO(snapshot.data['accent'][0],
          snapshot.data['accent'][1], snapshot.data['accent'][2], 1),
      tags: List<String>.from(snapshot.data['tags']),
      coverLocation: 'assets/images/covers/$titlePath.png',
      guideSections: guideSectionList,
    );
  }
}
