import 'dart:developer';

import 'package:L2P/components/bottomNav.dart';
import 'package:L2P/models/game.dart';
import 'package:L2P/components/guideSection.dart';
import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

class GuideList extends StatefulWidget {
  final Game game;
  GuideList({Key key, Game game})
      : this.game = game,
        super(key: key);

  @override
  _GuideListState createState() => _GuideListState();
}

class _GuideListState extends State<GuideList> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<Padding> _filteredList = new List();

  @override
  void initState() {
    super.initState();
    _filter.addListener(() {
      print("Second text field: ${_filter.text}");
      if (_filter.text.isEmpty && _searchText != "") {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Building GuideList...');
    List<Tab> tabsList = [];
    List<Padding> guideSectionLists = [];

    if (widget.game.guideSections.length > 0) {
      widget.game.guideSections.sort(GuideSection.sortByOrder);
      tabsList.add(Tab(text: "Guides", icon: Icon(Icons.local_library)));
      guideSectionLists.add(Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Column(
                children: widget.game.guideSections != null
                    ? (_searchText != ""
                        ? GuideSection.searchFilter(
                            widget.game.guideSections, _searchText)
                        : widget.game.guideSections)
                    : <Widget>[])
          ],
        ),
      ));
    }
    if (widget.game.referenceSections.length > 0) {
      widget.game.referenceSections.sort(GuideSection.sortByOrder);
      tabsList.add(Tab(text: "References", icon: Icon(Icons.library_books)));
      guideSectionLists.add(Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Column(
                children: widget.game.referenceSections != null
                    ? (_searchText != ""
                        ? GuideSection.searchFilter(
                            widget.game.referenceSections, _searchText)
                        : widget.game.referenceSections)
                    : <Widget>[])
          ],
        ),
      ));
    }
    if (widget.game.scenarioSections.length > 0) {
      widget.game.scenarioSections.sort(GuideSection.sortByOrder);
      tabsList.add(Tab(text: "Scenarios", icon: Icon(Icons.local_movies)));
      guideSectionLists.add(Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Column(
                children: widget.game.scenarioSections != null
                    ? (_searchText != ""
                        ? GuideSection.searchFilter(
                            widget.game.scenarioSections, _searchText)
                        : widget.game.scenarioSections)
                    : <Widget>[])
          ],
        ),
      ));
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          elevation: 40,
          title: new Image.asset(
            'icons/Logo.png',
            height: 20,
            width: 60,
            fit: BoxFit.contain,
          ),
          /* Text(
            'Learn to Play',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ), */
        ),
      ),
      bottomNavigationBar: BottomNav(),
      body: ListView(
        children: <Widget>[
          Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(widget.game.title.replaceAll('_', ' '),
                      style: Theme.of(context).textTheme.headline4)
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: widget.game.coverImage),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 12.0, left: 12.0, right: 12.0),
                child: Text(widget.game.description,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              DefaultTabController(
                length: tabsList.length,
                child: Flexible(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(color: Colors.black45),
                        child: TabBar(
                          tabs: tabsList,
                          labelColor: buttonSecondary,
                          unselectedLabelColor: uiElement,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 4),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(99))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: TextField(
                                          controller: _filter,
                                          decoration: new InputDecoration(
                                            hintText: 'Search',
                                            border: InputBorder.none,
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          )),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 340,
                        child: TabBarView(
                          children: guideSectionLists,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
