import 'dart:developer';

import 'package:L2P/components/bottomNav.dart';
import 'package:L2P/helpers/logger.dart';
import 'package:L2P/models/constants.dart';
import 'package:L2P/models/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:L2P/components/gameCard.dart';
import 'package:L2P/screens/guideList.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Library extends StatefulWidget {
  final AsyncSnapshot snapshot;

  Library({AsyncSnapshot snapshot}) : this.snapshot = snapshot;

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<Game> _gameList = <Game>[];

  @override
  void initState() {
    buildLibrary(widget.snapshot);
    super.initState();
  }

  void _appendToGameList(Game newGame) {
    List<Game> newList = _gameList;
    newList.add(newGame);
    newList.sort(Game.sortByOrder);
    setState(() {
      _gameList = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.connectionState == ConnectionState.done &&
        (_gameList == null || _gameList.length == 0)) {
      return new Text("Failed to fetch any documents.");
    }
    if (_gameList == null || _gameList.length == 0) {
      return new SpinKitFoldingCube(
          color: Theme.of(context).disabledColor, size: 75);
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      int layoutCrossAxis = 1;
      if (constraints.maxWidth >= Breakpoints.maxPhoneWidth) {
        layoutCrossAxis = 2;
        SharedLogger().noStack.d('Widescreen layout.');
      }
      return RefreshIndicator(
        onRefresh: _handleRefresh,
        child: CustomScrollView(
          slivers: <Widget>[
            PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: SliverAppBar(
                floating: true,
                centerTitle: true,
                elevation: 40,
                title: new Image.asset(
                  'icons/Logo.png',
                  height: 30,
                  width: 70,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 24, top: 24, left: 10, right: 10),
                    child: Container(
                      child: Text(
                          "Tap on any of the guides below to get started!",
                          style: Theme.of(context).textTheme.bodyText1),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),
            SliverStaggeredGrid.countBuilder(
              crossAxisCount: layoutCrossAxis,
              itemCount: _gameList.length,
              itemBuilder: (BuildContext context, int index) {
                Game game = _gameList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: RouteSettings(
                              arguments: NavigationArguments(Enum_Screens.game),
                              name: "currentGame"),
                          builder: (context) => GuideList(game: game)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 11.0, left: 11.0, right: 11.0),
                    child: new GameCard(
                        key: new Key('game_$index'),
                        title: game.title,
                        description: game.description,
                        tags: game.tags,
                        coverImage: game.coverImage),
                  ),
                );
              },
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            )
          ],
        ),
      );
    });
  }

  void buildLibrary(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) async {
    final logger = Logger();
    snapshot.data.docs.forEach((document) async {
      final doc = document as QueryDocumentSnapshot<Map<String, dynamic>>;
      // Check if debug flag is turned to true:
      final prefs = await SharedPreferences.getInstance();
      final debug = prefs.getBool(L2PSettings.debugOn) ?? 0;
      if (debug == true) {
        Game newGame = await Game.fromSnapshot(document);
        if (newGame != null) {
          _appendToGameList(newGame);
        }
      } else {
        if (doc.data()["prod"] is bool && doc.data()["prod"] == true) {
          Game newGame = await Game.fromSnapshot(document);
          if (newGame != null) {
            _appendToGameList(newGame);
          }
        }
      }
    });
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 1));
    setState(() {
      _gameList = [];
    });
    await buildLibrary(widget.snapshot);

    return null;
  }
}
