import 'package:L2P/screens/guide.dart';
import 'package:L2P/components/guideSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer';

class Game {
  // Fields
  String title;
  String description;
  Image coverImage;
  Color accent;
  List<String> tags;
  List<GuideSection> guideSections;
  CollectionReference guidesRef;

  Game({
    String title,
    String description,
    Image coverImage,
    Color accent,
    List<String> tags,
    List<GuideSection> guideSections,
  })  : this.title = title,
        this.description = description,
        this.tags = tags,
        this.coverImage = coverImage,
        this.accent = accent,
        this.guideSections = guideSections;

  void setGuideSections(List<GuideSection> sections) {
    this.guideSections = sections;
  }

  @override
  String toString() {
    String shortDesc = description.substring(0, 32);
    return '{\nTitle - $title\nDescription - $shortDesc\nCoverLocation - ${coverImage.toString()}\nAccent - $accent\nTags - $tags\nGuideSections - $guideSections\n}';
  }

  /// TODO: Replace this with individual models. E.G: Game, Guide, Page etc...
  static Future<Game> fromSnapshot(DocumentSnapshot snapshot) async {
    Game newGame;
    String titlePath =
        'cover_images/${snapshot.data['title'].replaceAll(' ', '_').toLowerCase()}.png';
    List<GuideSection> guideSectionList = new List<GuideSection>();

    // First, get the box image for the title:
    Image img;
    await FirebaseStorage.instance
        .ref()
        .child(titlePath)
        .getDownloadURL()
        .then((downloadURL) => {
              img = Image.network(
                downloadURL.toString(),
                fit: BoxFit.scaleDown,
              )
            });

    // Then get the game informatino for the title:
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
        coverImage: img,
        guideSections: guideSectionList,
      );
    }).catchError((error) {
      log(error);
      return null;
    });

    return newGame;
  }
}
