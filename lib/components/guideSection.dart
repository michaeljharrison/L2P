import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class GuideSection extends StatefulWidget {
  final String title;
  final String body;
  final bool ordered;
  final List<FlatButton> links;

  GuideSection({
    Key key,
    String title,
    String body,
    List<FlatButton> links,
    bool ordered = false,
  })  : this.title = title,
        this.body = body,
        this.ordered = ordered,
        this.links = links,
        super(key: key);

  @override
  _GuideSectionState createState() => _GuideSectionState();
}

class _GuideSectionState extends State<GuideSection> {
  @override
  Widget build(BuildContext context) {
    if (widget.ordered) {
    } else {}
    return Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: cardBG, borderRadius: BorderRadius.all(Radius.circular(4))),
        child: ExpandablePanel(
          theme: expandableThemeDefault,
          header:
              Text(widget.title, style: Theme.of(context).textTheme.display1),
          collapsed: Text(
            widget.body,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.body1,
          ),
          expanded: Column(
            children: <Widget>[
              Text(
                widget.body,
                softWrap: true,
                style: Theme.of(context).textTheme.body1,
              ),
              Column(
                children: widget.links,
              )
            ],
          ),
          tapHeaderToExpand: true,
          hasIcon: true,
        ));
  }
}
