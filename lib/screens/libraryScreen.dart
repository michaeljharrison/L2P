import 'package:L2P/components/bottomNav.dart';
import 'package:L2P/components/library.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:developer';

class LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('games').snapshots(),
      builder: (context, snapshot) {
        log('Connection: $snapshot');
        if (snapshot.connectionState == ConnectionState.active &&
            !snapshot.hasData) {
          return Text('No Data found.');
        }
        if (snapshot.connectionState == ConnectionState.active) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Stack(
              children: [
                new Padding(
                    padding: const EdgeInsets.only(
                        top: 11.0, left: 11.0, right: 11.0, bottom: 80.0),
                    child: Library(
                      snapshot: snapshot,
                    )),
              ],
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
      },
    );
  }
}

class LibraryScreen extends StatefulWidget {
  @override
  LibraryScreenState createState() => LibraryScreenState();
}
