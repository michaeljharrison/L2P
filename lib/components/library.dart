import 'package:L2P/components/game.dart';
import 'package:flutter/material.dart';
import 'package:L2P/components/gameCard.dart';
import 'package:L2P/screens/guideList.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Library {
  static Widget buildLibraryCards(
      BuildContext context, AsyncSnapshot snapshot) {
    int libraryLength = snapshot.data.documents.length;
    if (libraryLength == 0) {
      return Text("No Games in Collection.");
    }
    return CustomScrollView(
      slivers: <Widget>[
        SliverStaggeredGrid.countBuilder(
          crossAxisCount: 4,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int index) {
            Game game = Game.fromSnapshot(snapshot.data.documents[index]);
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
                  tags: game.tags),
            );
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        )
      ],
    );
  }
}
