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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Learn to Play',
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNav(),
      body: ListView(
        children: <Widget>[
          Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              DefaultTabController(
                length: 3,
                child: Flexible(
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        tabs: [
                          Tab(text: "Library", icon: Icon(Icons.local_library)),
                          Tab(
                              text: "References",
                              icon: Icon(Icons.library_books)),
                          Tab(
                              text: "Scenarios",
                              icon: Icon(Icons.local_movies)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                            height: 38,
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(99))),
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
                                    style: TextStyle(
                                        color: buttonPrimary, fontSize: 18),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 340,
                        child: TabBarView(
                          children: <Widget>[
                            ListView(
                              children: <Widget>[
                                Column(
                                    children: widget.game.guideSections != null
                                        ? widget.game.guideSections
                                        : <Widget>[])
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[Text("References.")],
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[Text("Scenarios")],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
