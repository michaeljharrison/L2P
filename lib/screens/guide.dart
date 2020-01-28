import 'dart:developer';

import 'package:L2P/components/page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

/// Guide Class
///
/// A guide is a title and a series of pages that can be
/// navigated through to explain the functionality
/// of a single element of a game.
class Guide extends StatefulWidget {
  /// Title for the guide, this is shared accross guide pages.
  final String title;

  /// Title of the game this guide belongs to.
  final String gameTitle;

  /// Document Snapshot, used to fetch the pages of a guide on demand.
  final DocumentSnapshot snapshot;

  /// Accent color for the guide, for initial version this is inerited from the game data itself.
  final Color accent;

  /// Constructor for a Guide object.
  ///
  /// Only takes the title and the document snapshot, this
  /// snapshot can fetch the pages in the guide on demand.
  Guide(
      {Key key,
      String title,
      DocumentSnapshot snapshot,
      String gameTitle,
      Color accent})
      : this.title = title,
        this.snapshot = snapshot,
        this.accent = accent,
        this.gameTitle = gameTitle,
        super(key: key);

  @override
  _GuideState createState() => _GuideState();
}

/// State class for the Guide Object.
class _GuideState extends State<Guide> {
  /// List of pages in a guide.
  List<Page> pages = <Page>[];

  void buildPageList() {
    log('Building Guide Page List...');
    widget.snapshot["pages"].forEach((page) {
      log('Adding page ${page["title"]}');
      setState(() {
        pages.add(new Page(
            title: page["title"],
            description: page["description"],
            imageLocation: page["imageLocation"]));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log('Rendering Guide: ');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Learn to Play',
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Container(
            decoration: BoxDecoration(color: cardBG),
            child: Column(
              children: <Widget>[
                Text(widget.gameTitle,
                    style: Theme.of(context).textTheme.headline),
                Text(widget.title, style: Theme.of(context).textTheme.subhead),
                Text("PROGRESS BAR GOES HERE",
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22.0, bottom: 22.0, left: 24.0),
            child: renderGuide(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                color: cardBG,
                child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Back to ${widget.gameTitle}',
                        style: TextStyle(color: buttonPrimary, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: buttonPrimary,
                        size: 14,
                        semanticLabel: 'Back to ${widget.gameTitle}',
                      )
                    ]),
              ),
            ),
          )
        ]));
  }

  Widget renderGuide() {
    buildPageList();
    return PageView.builder(
        controller: PageController(),
        itemBuilder: (BuildContext context, int itemIndex) {
          return pages[itemIndex];
        });
  }
}
