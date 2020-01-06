import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:L2P/components/gameCard.dart';
import 'package:L2P/models/dummyLibrary.dart';
import 'package:L2P/screens/guideList.dart';
import '../theme/theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverStaggeredGrid.countBuilder(
            crossAxisCount: 4,
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GuideList()),
                  );
                },
                child: new GameCard(
                    key: new Key('game_$index'),
                    title: libraryData[index].title,
                    description: libraryData[index].description),
              );
            },
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          )
        ],
      ),
    );
  }
}

class Library extends StatefulWidget {
  @override
  LibraryState createState() => LibraryState();
}
