import 'dart:developer';

import 'package:L2P/components/page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:L2P/theme/theme.dart';
import 'package:L2P/models/constants.dart';

/// Guide Class
///
/// A guide is a title and a series of pages that can be
/// navigated through to explain the functionality
/// of a single element of a game.
class Guide extends StatefulWidget {
  /// Title for the guide, this is shared accross guide pages.
  final String title;

  // Ordering of this guide within it's section.
  final int order;

  /// Title of the game this guide belongs to.
  final String gameTitle;

  /// Document Snapshot, used to fetch the pages of a guide on demand.
  final DocumentSnapshot snapshot;

  /// Accent color for the guide, for initial version this is inerited from the game data itself.
  final Color accent;

  /// Type of guide: guide(default), reference or score.
  final String type;

  /// Constructor for a Guide object.
  ///
  /// Only takes the title and the document snapshot, this
  /// snapshot can fetch the pages in the guide on demand.
  Guide(
      {Key key,
      String title,
      int order,
      DocumentSnapshot snapshot,
      String gameTitle,
      String type,
      Color accent})
      : this.title = title,
        this.order = order,
        this.snapshot = snapshot,
        this.accent = accent,
        this.type = type,
        this.gameTitle = gameTitle,
        super(key: key);

  @override
  _GuideState createState() => _GuideState();

  static int sortByOrder(Guide a, Guide b) {
    if (a.order < b.order) return -1;
    if (a.order == b.order)
      return 0;
    else
      return 1;
  }

  static Guide clone(Guide g) {
    return new Guide(
        title: g.title,
        order: g.order,
        snapshot: g.snapshot,
        accent: g.accent,
        type: g.type,
        gameTitle: g.gameTitle);
  }
}

/// State class for the Guide Object.
class _GuideState extends State<Guide> {
  /// List of pages in a guide.
  List<GuidePage> _pages = <GuidePage>[];
  int _currentPage = 0;

  void buildPageList() async {
    widget.snapshot.reference
        .collection('pages')
        .getDocuments()
        .then((documents) {
      documents.documents.forEach((page) async {
        GuidePage newPage = await GuidePage.fromSnapshot(page);
        setState(() {
          /// TODO: Create a function to build page from model instead of passing in fields.
          _pages.add(newPage);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_pages != null) {
      _pages.sort(GuidePage.sortByOrder);
    }
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            centerTitle: true,
            elevation: 40,
            title: new Image.asset(
              'icons/Logo.png',
              height: 20,
              width: 60,
              fit: BoxFit.contain,
            ),
            /* Text(
            'Learn to Play',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ), */
          ),
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 94,
              decoration: BoxDecoration(color: cardBG),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                child: Container(
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.gameTitle,
                          style: Theme.of(context).textTheme.headline5),
                      Text(widget.title,
                          style: Theme.of(context).textTheme.subtitle2),

                      /// TODO: Replace with a real progress bar..
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 50,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 1000,
                        animateFromLastPercent: true,
                        percent: ((_currentPage + 1) / _pages.length <= 1)
                            ? (_currentPage + 1) / _pages.length
                            : 0,
                        center: Text('${_currentPage + 1} / ${_pages.length}'),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Theme.of(context).buttonColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 102.0, bottom: 60.0),
            child: renderBody(),
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

  Widget renderBody() {
    switch (widget.type) {
      case SectionTypes.Guide:
        return renderGuide();
        break;
      case SectionTypes.Reference:
        return renderReference();
        break;
      default:
        return renderReference();
        break;
    }
  }

  Widget renderReference() {
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
