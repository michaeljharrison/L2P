import 'package:flutter/material.dart';
import 'package:L2P/components/tagList.dart';
import '../theme/theme.dart';

class GameCard extends StatelessWidget {
  final String title;
  final Image coverImage;
  final String description;
  final List<String> tags;

  GameCard(
      {Key key,
      String title,
      String description,
      List<String> tags,
      Image coverImage})
      : this.title = title,
        this.description = description,
        this.coverImage = coverImage,
        this.tags = tags;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: new BoxDecoration(
          gradient: backgroundCardGradient,
          borderRadius: new BorderRadius.all(Radius.circular(12)),
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
                child: new Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: new Container(
                // Game Image
                child: coverImage,
              ),
            ),
            new Container(
              // Game Description
              child: new Text(
                description,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: TagList(tags: tags),
            )
          ],
        ));
  }
}
