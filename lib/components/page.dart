import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

class Page extends StatefulWidget {
  final String title;
  final String description;
  final Image image;
  final int order;

  Page({Key key, String title, String description, Image image, int order})
      : this.title = title,
        this.description = description,
        this.image = image,
        this.order = order,
        super(key: key);

  @override
  _PageState createState() => _PageState();

  static int sortByOrder(Page a, Page b) {
    if (a.order < b.order) return -1;
    if (a.order == b.order)
      return 0;
    else
      return 1;
  }

  static Future<Page> fromSnapshot(DocumentSnapshot snapshot) async {
    // First, get the box image for the title:
    String imgPath = 'guides/${snapshot.data['Page Code']}.png';
    Image img;
    try {
      var downloadURL =
          await FirebaseStorage.instance.ref().child(imgPath).getDownloadURL();
      if (downloadURL != null) {
        img = Image.network(
          downloadURL.toString(),
          fit: BoxFit.scaleDown,
        );
      }
    } catch (error) {
      img = null;
      print(error.toString());
    }

    return Page(
        title: (snapshot.data["Title"] != null)
            ? snapshot.data["Title"]
            : "No Title",
        description: (snapshot.data["Instructions"] != null)
            ? snapshot.data["Instructions"]
            : "No Instructions.",
        image: img,
        order: (snapshot.data["Order"] != null)
            ? int.parse(snapshot.data["Order"])
            : 0);
  }
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pageContent = [];
    MainAxisAlignment pageAlignment = MainAxisAlignment.start;
    EdgeInsets pagePadding =
        EdgeInsets.only(top: 40, bottom: 6.0, left: 40, right: 40);
    EdgeInsets titlePadding = EdgeInsets.only(bottom: 20);

    if (widget.image != null) {
      log("Page has image");
      pageContent.add(Expanded(child: widget.image));
      pageAlignment = MainAxisAlignment.end;
      pagePadding = EdgeInsets.all(6.0);
      titlePadding = EdgeInsets.all(0);
    }
    pageContent.add(Padding(
      padding: titlePadding,
      child: Text(widget.title, style: Theme.of(context).textTheme.subhead),
    ));
    pageContent.add(
        Text(widget.description, style: Theme.of(context).textTheme.body2));

    return Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0, bottom: 6.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: cardBG,
          ),
          child: Padding(
            padding: pagePadding,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: pageAlignment,
              children: pageContent,
            ),
          )),
    );
  }
}
