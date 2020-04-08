import 'package:L2P/screens/guide.dart';
import 'package:L2P/components/guideSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer';

class Game {
  // Fields
  String title;
  String code;
  String description;
  Image coverImage;
  Color accent;
  List<String> tags;
  List<GuideSection> guideSections;
  CollectionReference guidesRef;

  Game({
    String title,
    String code,
    String description,
    Image coverImage,
    Color accent,
    List<String> tags,
    List<GuideSection> guideSections,
  })  : this.title = title,
        this.code = code,
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
    if (snapshot.data["title"] == null) {
      return null;
    }
    Game newGame;
    String titlePath = 'cover_images/${snapshot.data['code']}.png';
    List<GuideSection> guideSectionList = new List<GuideSection>();

    // First, get the box image for the title:
    Image img;
    try {
      var downloadURL = await FirebaseStorage.instance
          .ref()
          .child(titlePath)
          .getDownloadURL();
      if (downloadURL != null) {
        img = Image.network(
          downloadURL.toString(),
          fit: BoxFit.scaleDown,
        );
      }
    } catch (error) {
      img = Image.asset("Catan.png");
      print(error.toString());
    }

    // Then get the game information for the title:
    // First get a list of SECTIONS
    await snapshot.reference
        .collection("sections")
        .getDocuments()
        .then((guideSections) async {
      if (guideSections.documents.length > 0) {
        // FOR EACH SECTION
        await guideSections.documents.forEach((guideSection) async {
          CollectionReference guidesCollection =
              guideSection.reference.collection("guides");
          List<Guide> guideList = new List<Guide>();
          // Then get a list of GUIDES
          await guidesCollection.getDocuments().then((guides) async {
            log(guides.toString());
            if (guides.documents.length > 0) {
              // FOR EACH GUIDE
              await guides.documents.forEach((guide) {
                guideList.add(new Guide(
                  gameTitle: snapshot.data['title'],
                  title: guide["Name"],
                  // order: guide.data["Order"]
                  // accent: Color.fromRGBO(snapshot.data['accent'][0],
                  //    snapshot.data['accent'][1], snapshot.data['accent'][2], 1),
                  snapshot: guide,
                ));
              });
            }
          });

          guideSectionList.add(new GuideSection(
              title: guideSection['Section Name'],
              description: (guideSection['description'] != null)
                  ? guideSection['description']
                  : "No Description.",
              ordered: (guideSection['Order'] != null) ? true : false,
              order: int.parse(guideSection['Order']),
              guides: guideList));
        });
      }

      newGame = new Game(
        title: snapshot.data['title'],
        code: snapshot.data['code'],
        description: snapshot.data['description'],
        // accent: Color.fromRGBO(snapshot.data['accent'][0],
        // snapshot.data['accent'][1], snapshot.data['accent'][2], 1),
        // tags: List<String>.from([snapshot.data['tags']]),
        tags: List<String>.from([]),
        coverImage: img,
        guideSections: guideSectionList,
      );
    }).catchError((error) {
      log(error.toString());
      return null;
    });

    return newGame;
  }
}
