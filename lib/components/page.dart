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
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: cardBG,
          ),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Text(widget.imageLocation,
                    style: Theme.of(context).textTheme.body1),
              ),
              Text(widget.title, style: Theme.of(context).textTheme.subhead),
              Text(widget.description,
                  style: Theme.of(context).textTheme.body2),
            ],
          )),
    );
  }
}
