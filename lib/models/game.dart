import 'package:L2P/screens/guide.dart';
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

  @override
  String toString() {
    String shortDesc = description.substring(0, 32);
    return '{\nTitle - $title\nDescription - $shortDesc\nCoverLocation - $coverLocation\nAccent - $accent\nTags - $tags\nGuideSections - $guideSections\n}';
  }

  /// TODO: Replace this with individual models. E.G: Game, Guide, Page etc...
  static Future<Game> fromSnapshot(DocumentSnapshot snapshot) async {
    Game newGame;
    String titlePath = snapshot.data['title'].replaceAll(' ', '_');
    List<GuideSection> guideSectionList = new List<GuideSection>();
    await snapshot.reference
        .collection('sections')
        .getDocuments()
        .then((guideSections) async {
      guideSections.documents.forEach((guideSection) async {
        List<Guide> guideList = new List<Guide>();
        await guideSection.reference
            .collection('guides')
            .getDocuments()
            .then((guides) {
          guides.documents.forEach((guide) {
            guideList.add(new Guide(
              gameTitle: snapshot.data['title'],
              title: guide["title"],
              accent: Color.fromRGBO(snapshot.data['accent'][0],
                  snapshot.data['accent'][1], snapshot.data['accent'][2], 1),
              snapshot: guide,
            ));
          });
        });

        guideSectionList.add(new GuideSection(
            title: guideSection['title'],
            description: guideSection['description'],
            ordered: guideSection['ordered'],
            order: guideSection['order'],
            guides: guideList));
      });

      newGame = new Game(
        title: snapshot.data['title'],
        description: snapshot.data['description'],
        accent: Color.fromRGBO(snapshot.data['accent'][0],
            snapshot.data['accent'][1], snapshot.data['accent'][2], 1),
        tags: List<String>.from(snapshot.data['tags']),
        coverLocation: 'assets/images/covers/$titlePath.png',
        guideSections: guideSectionList,
      );
    });

    return newGame;
  }
}
