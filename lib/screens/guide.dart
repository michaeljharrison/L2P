import 'dart:developer';

import 'package:L2P/components/page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
  List<Page> _pages = <Page>[];
  int _currentPage = 0;

  void buildPageList() {
    log('Building Guide Page List...');
    widget.snapshot.reference
        .collection('pages')
        .getDocuments()
        .then((documents) {
      documents.documents.forEach((page) {
        log('Adding page ${page["title"]}');
        setState(() {
          /// TODO: Create a function to build page from model instead of passing in fields.
          _pages.add(new Page(
              title: page["title"],
              description: page["description"],
              imageLocation: page["imageLocation"]));
        });
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
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 134,
              decoration: BoxDecoration(color: widget.accent),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.gameTitle,
                        style: Theme.of(context).textTheme.headline),
                    Text(widget.title,
                        style: Theme.of(context).textTheme.subhead),

                    /// TODO: Replace with a real progress bar..
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 50,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 1000,
                      animateFromLastPercent: true,
                      percent: _currentPage / _pages.length,
                      center: Text('${_currentPage + 1} / ${_pages.length}'),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 102.0, bottom: 60.0),
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
    if (_pages.length < 1) {
      buildPageList();
    }
    return PageView.builder(
        controller: PageController(),
        itemCount: _pages.length,
        onPageChanged: (pageIndex) {
          setState(() {
            _currentPage = pageIndex;
          });
        },
        itemBuilder: (BuildContext context, int itemIndex) {
          return _pages[itemIndex];
        });
  }
}
