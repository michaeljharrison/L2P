import 'dart:math';

import 'package:L2P/screens/guide.dart';
import 'package:L2P/components/guideButton.dart';
import 'package:L2P/screens/scoringGuide.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class GuideSection extends StatefulWidget {
  final String title;
  final String description;
  final bool ordered;
  final int order;
  final List<Guide> guides;
  final List<ScoringGuide> scoringGuides;
  final String type;

  GuideSection({
    Key key,
    String title,
    String description,
    List<Guide> guides,
    int order,
    String type,
    List<ScoringGuide> scoringGuides,
    bool ordered = false,
  })  : this.title = title,
        this.description = description,
        this.ordered = ordered,
        this.order = order,
        this.guides = guides,
        this.scoringGuides = scoringGuides,
        this.type = type,
        super(key: key);

  @override
  _GuideSectionState createState() => _GuideSectionState();

  static int sortByOrder(GuideSection a, GuideSection b) {
    if (a.order < b.order) return -1;
    if (a.order == b.order)
      return 0;
    else
      return 1;
  }
}

class _GuideSectionState extends State<GuideSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: cardBG,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: ExpandablePanel(
            theme: expandableThemeDefault,
            header: Text(widget.title,
                style: Theme.of(context).textTheme.headline5),
            collapsed: Text(
              widget.description,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            expanded: Column(
              children: <Widget>[
                Text(
                  widget.description,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Column(
                  children: buildButtonList(),
                )
              ],
            ),
            tapHeaderToExpand: true,
            hasIcon: true,
          )),
    );
  }

  List<Widget> buildButtonList() {
    List<Widget> buttonList = new List<Widget>();
    if (widget.scoringGuides.length > 0) {
      for (var i = 0; i < widget.scoringGuides.length; i++) {
        buttonList.add(GuideButton(
            key: Key(Random(0).toString()),
            index: widget.scoringGuides[i].order,
            title: widget.scoringGuides[i].title,
            type: widget.type,
            numbered: false,
            link: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => widget.scoringGuides[i]),
              );
            }));
      }
    }
    widget.guides.sort(Guide.sortByOrder);
    if (widget.guides.length > 0) {
      for (var i = 0; i < widget.guides.length; i++) {
        buttonList.add(GuideButton(
            key: Key(Random(0).toString() +
                "_" +
                widget.title.toString() +
                "_" +
                widget.guides[i].toString() +
                '_' +
                widget.guides[i].order.toString()),
            index: widget.guides[i].order,
            title: widget.guides[i].title,
            type: widget.type,
            numbered: widget.ordered,
            link: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget.guides[i]),
              );
            }));
      }
    }
    return buttonList;
  }
}
