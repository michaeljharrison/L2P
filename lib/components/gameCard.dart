import 'package:flutter/material.dart';
import 'package:L2P/components/tagList.dart';
import '../theme/theme.dart';

class GameCard extends StatelessWidget {
  final String title;
  final String coverLocation;
  final String description;
  final List<String> tags;

  GameCard({Key key, String title, String description, List<String> tags})
      : this.title = title,
        this.description = description,
        this.coverLocation =
            'assets/images/covers/${title.replaceAll(' ', '_')}.png',
        this.tags = tags;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(6),
        decoration: new BoxDecoration(
          color: cardBG,
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
                child: new Text(title,
                    style: Theme.of(context).textTheme.headline),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: new Container(
                // Game Image
                child: new Image.asset(coverLocation),
              ),
            ),
            new Container(
              // Game Description
              child: new Text(
                description,
                style: Theme.of(context).textTheme.body1,
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
