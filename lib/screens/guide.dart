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
  String title;

  /// Document Snapshot, used to fetch the pages of a guide on demand.
  DocumentSnapshot snapshot;

  /// Constructor for a Guide object.
  ///
  /// Only takes the title and the document snapshot, this
  /// snapshot can fetch the pages in the guide on demand.
  Guide({Key key, String title, DocumentSnapshot snapshot})
      : this.title = title,
        this.snapshot = snapshot,
        super(key: key);

  @override
  _guideState createState() => _guideState();
}

/// State class for the Guide Object.
class _guideState extends State<Guide> {
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
    log(pages.toString());
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
          renderGuide(),
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
                        'Back to Library',
                        style: TextStyle(color: buttonPrimary, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: buttonPrimary,
                        size: 14,
                        semanticLabel: 'Back to Library',
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
