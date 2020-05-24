import 'dart:developer';

import 'package:L2P/components/page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:L2P/theme/theme.dart';
import 'package:L2P/models/constants.dart';

class ScoringAttribute {
  final String title;
  final String description;
  final String pageCode;
  final int order;

  ScoringAttribute(
      {String title, String description, String pageCode, int order})
      : this.title = title,
        this.description = description,
        this.pageCode = pageCode,
        this.order = order;

  static Future<ScoringAttribute> fromSnapshot(
      DocumentSnapshot snapshot) async {
    return ScoringAttribute(
        title: (snapshot.data["Label"] != null) ? snapshot.data["Label"] : "",
        description: (snapshot.data["Instructions"] != null)
            ? snapshot.data["Instructions"]
            : "No Instructions.",
        order: (snapshot.data["AutoOrder"] != null)
            ? int.parse(snapshot.data["AutoOrder"])
            : 0,
        pageCode: (snapshot.data["Link"] != null) ? snapshot.data["Link"] : "");
  }

  static int sortByOrder(ScoringAttribute a, ScoringAttribute b) {
    if (a.order < b.order) return -1;
    if (a.order == b.order)
      return 0;
    else
      return 1;
  }
}

class ScoringGuide extends StatefulWidget {
  final String title;
  final String gameTitle;
  final int order;
  final int numPlayers;
  final DocumentSnapshot snapshot;
  List<List<int>> playerScores;

  ScoringGuide(
      {Key key,
      String title,
      String gameTitle,
      int numPlayers,
      int order,
      DocumentSnapshot snapshot})
      : this.title = title,
        this.gameTitle = gameTitle,
        this.order = order,
        this.numPlayers = numPlayers,
        this.snapshot = snapshot,
        super(key: key);

  @override
  _ScoringGuideState createState() => _ScoringGuideState();
}

class _ScoringGuideState extends State<ScoringGuide> {
  List<ScoringAttribute> _attributes = [];

  @override
  void initState() {
    buildAttributeList();
    super.initState();
  }

  void buildAttributeList() async {
    widget.snapshot.reference
        .collection('pages')
        .getDocuments()
        .then((documents) {
      documents.documents.forEach((page) async {
        ScoringAttribute newAttribute =
            await ScoringAttribute.fromSnapshot(page);
        setState(() {
          /// TODO: Create a function to build page from model instead of passing in fields.
          _attributes.add(newAttribute);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build the list of attributes for scoring.
    if (_attributes.length < 1) {
      buildAttributeList();
    }

    if (widget.playerScores == null && _attributes.length > 0) {
      // Build the 2D array of scoring attributes for each player.
      widget.playerScores = new List<List<int>>(widget.numPlayers);
      // Initialise a normal array to store each players score.
      for (var i = 0; i < widget.playerScores.length; i++) {
        if (widget.playerScores[i] == null) {
          widget.playerScores[i] = List<int>(_attributes.length);
          for (var j = 0; j < widget.playerScores[i].length; j++) {
            // Initialise all values to 0.
            widget.playerScores[i][j] = 0;
          }
        }
      }
    }

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
                          style: Theme.of(context).textTheme.headline),
                      Text(widget.title,
                          style: Theme.of(context).textTheme.subhead),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 102.0, bottom: 60.0),
            child: _attributes.length > 0
                ? renderBody(_attributes)
                : Text("Loading..."),
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

  Widget renderBody(List<ScoringAttribute> attributes) {
    List<Tab> tabBars = [];
    List<Widget> tabViews = [];

    for (var player = 0; player < widget.numPlayers; player++) {
      tabBars
          .add(Tab(text: 'Player ${player}', icon: Icon(Icons.person_outline)));
      tabViews.add(renderPlayerScoring(attributes, player));
    }
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        DefaultTabController(
            length: widget.numPlayers,
            child: Flexible(
              child: Column(
                children: <Widget>[
                  TabBar(tabs: tabBars),
                  Container(
                      height: MediaQuery.of(context).size.height - 340,
                      child: TabBarView(children: tabViews))
                ],
              ),
            ))
      ],
    );
  }

  Widget renderPlayerScoring(List<ScoringAttribute> attributes, int player) {
    List<Widget> categoryWidgets = [];
    for (var cat = 0; cat < attributes.length; cat++) {
      categoryWidgets.add(renderScoringCategory(cat, attributes[cat], player));
    }
    return Column(children: categoryWidgets);
  }

  Widget renderScoringCategory(
      int order, ScoringAttribute attribute, int player) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 14),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    attribute.title,
                    textAlign: TextAlign.start,
                  ),
                ),
                Icon(Icons.help_outline)
              ]),
              Text(
                attribute.description,
                textAlign: TextAlign.start,
              )
            ]),
          ),
        ),
        Container(
            width: 38,
            height: 38,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                widget.playerScores[player][order] != null
                    ? widget.playerScores[player][order].toString()
                    : "0",
                textAlign: TextAlign.center,
              ),
            ))
      ],
    );
  }
}
