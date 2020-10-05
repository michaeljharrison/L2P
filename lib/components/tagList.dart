import 'package:flutter/material.dart';
import '../theme/theme.dart';

class TagList extends StatelessWidget {
  final List<String> tags;
  final WrapAlignment align;
  final bool glow;

  const TagList(
      {Key key,
      List<String> tags,
      WrapAlignment align = WrapAlignment.start,
      bool glow = false})
      : this.tags = tags,
        this.align = align,
        this.glow = glow,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tagWidgets = List<Widget>();
    this.tags.forEach((tag) {
      tagWidgets.add(Tag(
          value: tag.toUpperCase(),
          color: Theme.of(context).disabledColor,
          glow: this.glow));
    });
    return new Flex(
        // Game Tags
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: new Wrap(
                alignment: this.align,
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
  final bool glow;

  const Tag({Key key, String value, Color color, bool glow = false})
      : this.value = value,
        this.color = color,
        this.glow = glow,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: this.color,
            boxShadow: this.glow != false
                ? [
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset.zero,
                        blurRadius: 3.0)
                  ]
                : [BoxShadow()],
            borderRadius: BorderRadius.all(Radius.circular(99))),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child:
              new Text(this.value, style: Theme.of(context).textTheme.button),
        ));
  }
}
