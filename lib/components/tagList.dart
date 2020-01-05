import 'package:flutter/material.dart';
import '../theme/theme.dart';

class TagList extends StatelessWidget {
  const TagList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Flex(
        // Game Tags
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: new Wrap(
              alignment: WrapAlignment.start,
              spacing: 4,
              runSpacing: 4,
              children: <Widget>[
                Tag(value: 'TAG A', color: colorTagTeal),
                Tag(value: 'TAG B', color: colorTagTeal),
                Tag(value: 'TAG C', color: colorTagTeal),
              ],
            ),
          )
        ]);
  }
}

class Tag extends StatelessWidget {
  final String value;
  final Color color;

  const Tag({Key key, String value, Color color})
      : this.value = value,
        this.color = color,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: this.color,
            borderRadius: BorderRadius.all(Radius.circular(99))),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child:
              new Text(this.value, style: Theme.of(context).textTheme.button),
        ));
  }
}
