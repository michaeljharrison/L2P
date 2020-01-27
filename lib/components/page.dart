import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

class Page extends StatefulWidget {
  final String title;
  final String description;
  final String imageLocation;

  Page({Key key, String title, String description, String imageLocation})
      : this.title = title,
        this.description = description,
        this.imageLocation = imageLocation,
        super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
          "${widget.title} - ${widget.description} - ${widget.imageLocation}"),
    );
  }
}
