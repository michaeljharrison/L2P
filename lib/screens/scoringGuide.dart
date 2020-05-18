import 'dart:developer';

import 'package:L2P/components/page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:L2P/theme/theme.dart';
import 'package:L2P/models/constants.dart';

class ScoringGuide extends StatefulWidget {
  final String title;
  final String gameTitle;
  final int order;
  final DocumentSnapshot snapshot;

  ScoringGuide(
      {Key key,
      String title,
      String gameTitle,
      int order,
      DocumentSnapshot snapshot})
      : this.title = title,
        this.gameTitle = gameTitle,
        this.order = order,
        this.snapshot = snapshot,
        super(key: key);

  @override
  _ScoringGuideState createState() => _ScoringGuideState();
}

class _ScoringGuideState extends State<ScoringGuide> {
  @override
  Widget build(BuildContext context) {
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
    const int numPlayers = 4;
    List<Tab> tabBars = [];
    List<Widget> tabViews = [];

    for (var player = 0; player < numPlayers; player++) {
      tabBars
          .add(Tab(text: 'Player ${player}', icon: Icon(Icons.person_outline)));
      tabViews.add(renderPlayerScoring());
    }
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        DefaultTabController(
            length: numPlayers,
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

  Widget renderPlayerScoring() {
    const scoringCategoriesLength = 6;
    List<Widget> categoryWidgets = [];
    for (var cat = 0; cat < scoringCategoriesLength; cat++) {
      categoryWidgets.add(renderScoringCategory());
    }
    return Column(children: categoryWidgets);
  }

  Widget renderScoringCategory() {
    return Row(
      children: <Widget>[
        Column(children: <Widget>[
          Row(children: <Widget>[Text("TITLE"), Icon(Icons.help_outline)]),
          Text("Description Lorem Ipsum Blah Blah.")
        ]),
        Container(child: Text("9"))
      ],
    );
  }
}
