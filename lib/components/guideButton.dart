import 'package:L2P/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

class GuideButton extends StatelessWidget {
  final bool numbered;
  final String title;
  final int index;
  final Function link;
  final String type;

  const GuideButton(
      {Key key,
      bool numbered,
      String title,
      int index,
      Function link,
      String type})
      : this.numbered = numbered,
        this.title = title,
        this.index = index,
        this.link = link,
        this.type = type,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.numbered) {
      return Flex(
          direction: Axis.horizontal,
          children: List<Widget>.from([
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Container(
                width: 40,
                child: FlatButton(
                  padding: EdgeInsets.all(4),
                  onPressed: link,
                  child: Text(this.index.toString(),
                      style: Theme.of(context).textTheme.button),
                  color: type == SectionTypes.Reference
                      ? buttonTertiary
                      : buttonPrimary,
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                onPressed: link,
                child:
                    Text(this.title, style: Theme.of(context).textTheme.button),
                color: type == SectionTypes.Reference
                    ? buttonTertiary
                    : buttonPrimary,
              ),
            ),
          ]));
    } else {
      return Flex(
        direction: Axis.horizontal,
        children: List<Widget>.from([
          Expanded(
            child: FlatButton(
              onPressed: link,
              child:
                  Text(this.title, style: Theme.of(context).textTheme.button),
              color: buttonSecondary,
            ),
          )
        ]),
      );
    }
  }
}
