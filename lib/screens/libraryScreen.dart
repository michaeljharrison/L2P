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
          return new Padding(
              padding: const EdgeInsets.all(11.0),
              child: Library(
                snapshot: snapshot,
              ));
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
