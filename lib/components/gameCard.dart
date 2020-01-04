import 'package:flutter/material.dart';
import 'package:hello_world/components/tagList.dart';
import '../theme/theme.dart';

class GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(6),
        decoration: new BoxDecoration(
          color: colorBGLight,
          borderRadius: new BorderRadius.all(Radius.circular(6)),
        ),
        child: new Column(
          children: <Widget>[
            new Container(
              // Game Title
              width: 1000,
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Theme.of(context).dividerColor))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: new Text(widget.title,
                    style: Theme.of(context).textTheme.headline),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: new Container(
                // Game Image
                child: new Image.asset(widget.coverLocation),
              ),
            ),
            new Container(
              // Game Description
              child: new Text(
                widget.description,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: TagList(),
            )
          ],
        ));
  }
}

class GameCard extends StatefulWidget {
  final String title;
  String coverLocation;
  // final String imgPath;
  final String description;
  // final List<String> tags;

  GameCard({Key key, String title, String description})
      : this.title = title.replaceAll('_', ' '),
        this.description = description,
        this.coverLocation = 'assets/images/covers/$title.png',
        super(key: key);

  @override
  GameCardState createState() => GameCardState();
}
