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
    return Container(
        child: ExpandablePanel(
      header: Text(widget.title),
      collapsed: Text(
        widget.body,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      expanded: Column(
        children: <Widget>[
          Text(
            widget.body,
            softWrap: true,
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
