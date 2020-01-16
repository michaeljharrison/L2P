import 'package:flutter/material.dart';
import '../theme/theme.dart';

class TagList extends StatelessWidget {
  final List<String> tags;

  const TagList({
    Key key,
    List<String> tags,
  })  : this.tags = tags,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tagWidgets = List<Widget>();
    this.tags.forEach((tag) {
      tagWidgets.add(Tag(value: tag, color: colorTagTeal));
    });
    return new Flex(
        // Game Tags
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            child: new Wrap(
                alignment: WrapAlignment.start,
                spacing: 4,
                runSpacing: 4,
                children: tagWidgets),
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
