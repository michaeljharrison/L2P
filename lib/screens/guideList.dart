import 'package:flutter/material.dart';
import 'package:L2P/components/guideSection.dart';
import 'package:L2P/theme/theme.dart';
import 'package:search_widget/search_widget.dart';

class GuideList extends StatefulWidget {
  GuideList({Key key}) : super(key: key);

  @override
  _GuideListState createState() => _GuideListState();
}

class _GuideListState extends State<GuideList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Learn to Play',
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text("TITLE"),
              Image.asset('assets/images/covers/Fog_Of_Love.png'),
              Text(
                  "7 Wonders Duel is a quick-fire, two-player variant of the hit game 7 Wonders. This guide will take you all the way from setup to playing through a full game, and contains a number of handy reference materials to keep your game going smoothly."),
              Container(child: Text("Search...")),
              GuideSection(
                title: 'Setup',
                body: 'Before you play, let’s setup a few componenets.',
                ordered: false,
                links: List<FlatButton>.filled(
                    1,
                    FlatButton(
                      child: Text("Button"),
                    )),
              ),
              GuideSection(
                title: 'Construction',
                body: 'Before you play, let’s setup a few componenets.',
                ordered: false,
                links: List<FlatButton>.filled(
                    1,
                    FlatButton(
                      child: Text("Button"),
                    )),
              ),
              GuideSection(
                title: 'Winning the Game',
                body: 'Before you play, let’s setup a few componenets.',
                ordered: false,
                links: List<FlatButton>.filled(
                    1,
                    FlatButton(
                      child: Text("Button"),
                    )),
              )
            ],
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
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Back"),
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
