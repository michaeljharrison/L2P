import 'package:L2P/components/guideButton.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class GuideSection extends StatefulWidget {
  final String title;
  final String body;
  final bool ordered;
  final List<String> buttonTitles;

  GuideSection({
    Key key,
    String title,
    String body,
    List<String> buttonTitles,
    bool ordered = false,
  })  : this.title = title,
        this.body = body,
        this.ordered = ordered,
        this.buttonTitles = buttonTitles,
        super(key: key);

  @override
  _GuideSectionState createState() => _GuideSectionState();
}

class _GuideSectionState extends State<GuideSection> {
  @override
  Widget build(BuildContext context) {
    if (widget.ordered) {
    } else {}
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
    for (var i = 0; i < widget.buttonTitles.length; i++) {
      buttonList.add(GuideButton(
        key: Key(i.toString()),
        index: i,
        title: widget.buttonTitles[i],
        numbered: widget.ordered,
      ));
    }
    return buttonList;
  }
}
