import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:L2P/components/gameCard.dart';
import 'package:L2P/models/dummyLibrary.dart';
import 'package:L2P/screens/guideList.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:developer';

class LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('games').snapshots(),
      builder: (context, snapshot) {
        log('game: $snapshot');
        if (!snapshot.hasData) {
          return const Text('Loading');
        } else {
          return new Padding(
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
                          MaterialPageRoute(
                              builder: (context) =>
                                  GuideList(game: libraryData[index])),
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
      },
    );
  }
}

class Library extends StatefulWidget {
  @override
  LibraryState createState() => LibraryState();
}
