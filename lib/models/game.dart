import 'package:L2P/helpers/logger.dart';
import 'package:L2P/screens/guide.dart';
import 'package:L2P/components/guideSection.dart';
import 'package:L2P/models/constants.dart';
import 'package:L2P/screens/scoringGuide.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:developer';

class Game {
  // Fields
  String title;
  String code;
  String description;
  FadeInImage coverImage;
  Color accent;
  List<String> tags;
  List<GuideSection> guideSections;
  List<GuideSection> referenceSections;
  List<GuideSection> scenarioSections;
  CollectionReference guidesRef;

  Game(
      {String title,
      String code,
      String description,
      FadeInImage coverImage,
      Color accent,
      List<String> tags,
      List<GuideSection> guideSections,
      List<GuideSection> referenceSections,
      List<GuideSection> scenarioSections})
      : this.title = title,
        this.code = code,
        this.description = description,
        this.tags = tags,
        this.coverImage = coverImage,
        this.accent = accent,
        this.guideSections = guideSections,
        this.referenceSections = referenceSections,
        this.scenarioSections = scenarioSections;

  @override
  String toString() {
    String shortDesc = description.substring(0, 32);
    return '{\nTitle - $title\nDescription - $shortDesc\nCoverLocation - ${coverImage.toString()}\nAccent - $accent\nTags - $tags\nGuideSections - $guideSections\n}';
  }

  static int sortByOrder(Game a, Game b) {
    return (a.title.compareTo(b.title));
  }

  /// TODO: Replace this with individual models. E.G: Game, Guide, Page etc...
  static Future<Game> fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.data()["title"] == null) {
      return null;
    }
    Game newGame;
    String titlePath = 'cover_images/${snapshot.data()['code']}.png';
    List<GuideSection> guideSectionList = new List<GuideSection>();
    List<GuideSection> scenarioSectionList = new List<GuideSection>();
    List<GuideSection> referenceSectionList = new List<GuideSection>();

    // First, get the box image for the title:
    FadeInImage img;
    try {
      var downloadURL = await FirebaseStorage.instance
          .ref()
          .child(titlePath)
          .getDownloadURL();
      if (downloadURL != null) {
        img = FadeInImage.assetNetwork(
          placeholder: 'icons/Loading.png',
          image: downloadURL.toString(),
          fit: BoxFit.fitHeight,
        );
      }
    } catch (error) {
      img = FadeInImage.assetNetwork(
        placeholder: 'icons/Loading.png',
        image: 'icons/Logo.png',
        fit: BoxFit.scaleDown,
      );
      SharedLogger().log.e(error.toString());
    }

    // Then get the game information for the title:
    // First get a list of SECTIONS

    await snapshot.reference
        .collection("sections")
        .get()
        .then((guideSections) async {
      if (guideSections.docs.length > 0) {
        // FOR EACH SECTION
        await guideSections.docs.forEach((guideSection) async {
          CollectionReference<Map<String, dynamic>> guidesCollection =
              guideSection.reference.collection("guides");
          List<Widget> guideList = new List<Guide>();

          // Then get a list of GUIDES
          List<ScoringGuide> sgs = new List<ScoringGuide>();
          await guidesCollection.get().then((guides) async {
            if (guides.docs.length > 0) {
              // FOR EACH GUIDE
              await guides.docs.forEach((guide) {
                if (guideSection["Section Type"] == SectionTypes.Scoring) {
                  sgs.add(
                    new ScoringGuide(
                        title: guide["Name"],
                        gameTitle: snapshot.data()['title'],
                        numPlayers: ((guide.data()["maxPlayers"] != null)
                            ? int.parse(guide.data()["maxPlayers"])
                            : 2),
                        snapshot: guide),
                  );
                } else {
                  guideList.add(new Guide(
                    gameTitle: snapshot.data()['title'],
                    title: guide["Name"],
                    order: ((guide.data()["Order"] != null &&
                            guide.data()["Order"] is String &&
                            guide.data()["Order"] != '')
                        ? int.parse(guide.data()["Order"])
                        : 0),
                    type: ((guideSection["Section Type"] != null)
                        ? guideSection["Section Type"]
                        : SectionTypes.Scoring),
                    getNextGuide: (order) {
                      if (order - 1 >= guideList.length) {
                        if (int.parse(guideSection['Order']) >=
                            guideSectionList.length) {
                          return null;
                        }
                        return guideSectionList[
                                int.parse(guideSection['Order'])]
                            .guides[0];
                      } else {
                        Guide match;
                        guideList.forEach((element) {
                          Guide g = element as Guide;
                          if (g.order == order + 1) {
                            match = g;
                          }
                        });
                        return match;
                      }
                    },
                    // accent: Color.fromRGBO(snapshot.data['accent'][0],
                    //    snapshot.data['accent'][1], snapshot.data['accent'][2], 1),
                    snapshot: guide,
                  ));
                }
              });
            }
          });

          GuideSection gs = new GuideSection(
              title: guideSection['Label'],
              description: (guideSection['Description'] != null)
                  ? guideSection['Description']
                  : "",
              ordered: (guideSection['Order'] != null) ? true : false,
              order: int.parse(guideSection['Order']),
              type: ((guideSection["Section Type"] != null)
                  ? guideSection["Section Type"]
                  : SectionTypes.Scoring),
              guides: guideList,
              scoringGuides: sgs);

          switch (guideSection["Section Type"]) {
            case SectionTypes.Guide:
              guideSectionList.add(gs);
              break;
            case SectionTypes.Reference:
              referenceSectionList.add(gs);
              break;
            case SectionTypes.Scenario:
              scenarioSectionList.add(gs);
              break;
            case SectionTypes.Scoring:
              // TODO: Uncomment this to re-enable scoring.
              // referenceSectionList.add(gs);
              break;
            default:
              guideSectionList.add(gs);
              break;
          }
        });
      }

      List<String> tagList = List<String>.from([]);
      if (snapshot.data()['playersLabel'] != null) {
        tagList.add('${snapshot.data()['playersLabel']} Players');
      }
      if (snapshot.data()['genre'] != null) {
        tagList.add(snapshot.data()['genre']);
      }
      newGame = new Game(
          title: snapshot.data()['title'],
          code: snapshot.data()['code'],
          description: snapshot.data()['description'],
          // accent: Color.fromRGBO(snapshot.data['accent'][0],
          // snapshot.data['accent'][1], snapshot.data['accent'][2], 1),
          tags: tagList,
          coverImage: img,
          guideSections: guideSectionList,
          referenceSections: referenceSectionList,
          scenarioSections: scenarioSectionList);
    }).catchError((error) {
      log(error.toString());
      return null;
    });

    return newGame;
  }
}
