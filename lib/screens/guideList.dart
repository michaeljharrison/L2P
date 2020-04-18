import 'package:L2P/components/bottomNav.dart';
import 'package:L2P/models/game.dart';
import 'package:L2P/components/guideSection.dart';
import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

class GuideList extends StatefulWidget {
  final Game game;
  GuideList({Key key, Game game})
      : this.game = game,
        super(key: key);

  @override
  _GuideListState createState() => _GuideListState();
}

class _GuideListState extends State<GuideList> {
  @override
  Widget build(BuildContext context) {
    if (widget.game.guideSections != null) {
      widget.game.guideSections.sort(GuideSection.sortByOrder);
    }
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
            padding: EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 55),
            child: ListView(
              children: <Widget>[
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.game.title.replaceAll('_', ' '),
                        style: Theme.of(context).textTheme.display1)
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: widget.game.coverImage),
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

                            /// TODO: Replace with a real search function.
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
                    children: widget.game.guideSections != null
                        ? widget.game.guideSections
                        : <Widget>[])
              ],
            ),
          ),
          BottomNav()
        ],
      ),
    );
  }
}
