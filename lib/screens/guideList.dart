import 'package:L2P/models/gameData.dart';
import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

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
          Container(
            padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 55),
            child: ListView(
              children: <Widget>[
                Text(widget.game.title,
                    style: Theme.of(context).textTheme.title),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Image.asset('assets/images/covers/Fog_Of_Love.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(widget.game.description,
                      style: Theme.of(context).textTheme.body1),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.all(Radius.circular(99))),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Search...",
                              style:
                                  TextStyle(color: buttonPrimary, fontSize: 18),
                            ),
                          )
                        ],
                      )),
                ),
                Column(
                  children: widget.game.guideSections,
                )
              ],
            ),
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
        ],
      ),
    );
  }
}
