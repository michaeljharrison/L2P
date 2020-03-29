import 'dart:developer';

import 'package:L2P/models/game.dart';
import 'package:flutter/material.dart';
import 'package:L2P/components/gameCard.dart';
import 'package:L2P/screens/guideList.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    log('Init Library State...');
    buildLibrary(widget.snapshot);
    super.initState();
  }

  void _appendToGameList(Game newGame) {
    log('Appending game to game list...');
    List<Game> newList = _gameList;
    newList.add(newGame);
    setState(() {
      _gameList = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('Building Library widget...');
    log(widget.snapshot.connectionState.toString());
    if (widget.snapshot.connectionState == ConnectionState.done &&
        (_gameList == null || _gameList.length == 0)) {
      return new Text("Failed to fetch any documents.");
    }
    if (_gameList == null || _gameList.length == 0) {
      log('game list is empty...');
      return new Text("Game list empty.");
    }
    return CustomScrollView(
      slivers: <Widget>[
        SliverStaggeredGrid.countBuilder(
          crossAxisCount: 4,
          itemCount: _gameList.length,
          itemBuilder: (BuildContext context, int index) {
            Game game = _gameList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GuideList(game: game)),
                );
              },
              child: new GameCard(
                  key: new Key('game_$index'),
                  title: game.title,
                  description: game.description,
                  tags: game.tags,
                  coverImage: game.coverImage),
            );
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        )
      ],
    );
  }

  void buildLibrary(AsyncSnapshot snapshot) async {
    log('Building Library State...');
    snapshot.data.documents.forEach((document) async {
      if (document.data["prod"] is bool && document.data["prod"] == true) {
        Game newGame = await Game.fromSnapshot(document);
        if (newGame != null) {
          _appendToGameList(newGame);
        }
      }
    });
  }
}
