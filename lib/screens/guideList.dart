import 'package:L2P/models/gameData.dart';
import 'package:flutter/material.dart';
import 'package:L2P/components/guideSection.dart';
import 'package:L2P/theme/theme.dart';
import 'package:search_widget/search_widget.dart';

class GuideList extends StatefulWidget {
  GameData game;
  GuideList({Key key, GameData game})
      : this.game = game,
        super(key: key);

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
              Text(widget.game.title, style: Theme.of(context).textTheme.title),
              Image.asset('assets/images/covers/Fog_Of_Love.png'),
              Text(widget.game.description,
                  style: Theme.of(context).textTheme.body1),
              Container(child: Text("Search...")),
              GuideSection(
                title: 'Beginner Tutorial',
                body: 'Before you play, let’s setup a few componenets.',
                ordered: false,
                links: List<FlatButton>.from([
                  FlatButton(
                    child: Text("Play Tutorial"),
                  ),
                ]),
              ),
              GuideSection(
                title: 'Setup',
                body: 'Before you play, let’s setup a few componenets.',
                ordered: true,
                links: List<FlatButton>.from([
                  FlatButton(
                    child: Text("Setting up the board"),
                  ),
                  FlatButton(
                    child: Text("Do another thing"),
                  )
                ]),
              ),
              GuideSection(
                title: 'Construction',
                body: 'Before you play, let’s setup a few componenets.',
                ordered: true,
                links: List<FlatButton>.from([
                  FlatButton(
                    child: Text("Setting up the board"),
                  ),
                  FlatButton(
                    child: Text("Do another thing"),
                  )
                ]),
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
