import 'package:L2P/screens/guide.dart';
import 'package:L2P/components/guideButton.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class GuideSection extends StatefulWidget {
  final String title;
  final String description;
  final bool ordered;
  final int order;
  final List<Guide> guides;

  GuideSection({
    Key key,
    String title,
    String description,
    List<Guide> guides,
    int order,
    bool ordered = false,
  })  : this.title = title,
        this.description = description,
        this.ordered = ordered,
        this.order = order,
        this.guides = guides,
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
            header:
                Text(widget.title, style: Theme.of(context).textTheme.headline),
            collapsed: Text(
              widget.description,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.body1,
            ),
            expanded: Column(
              children: <Widget>[
                Text(
                  widget.description,
                  softWrap: true,
                  style: Theme.of(context).textTheme.body1,
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
    widget.guides.sort(Guide.sortByOrder);
    for (var i = 0; i < widget.guides.length; i++) {
      buttonList.add(GuideButton(
          key: Key(widget.guides[i].order.toString()),
          index: widget.guides[i].order,
          title: widget.guides[i].title,
          numbered: widget.ordered,
          link: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.guides[i]),
            );
          }));
    }
    return buttonList;
  }
}
