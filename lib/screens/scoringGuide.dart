// TODO: BUG - Entering data in one player, then a second player, will wipe the first players data but not total score.
import 'package:L2P/helpers/logger.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

class ScoringAttribute {
  final String title;
  final String description;
  final String pageCode;
  final int order;

  ScoringAttribute(
      {String title, String description, String pageCode, int order})
      : this.title = title,
        this.description = description,
        this.pageCode = pageCode,
        this.order = order;

  static Future<ScoringAttribute> fromSnapshot(
      DocumentSnapshot snapshot) async {
    return ScoringAttribute(
        title:
            (snapshot.data()["Label"] != null) ? snapshot.data()["Label"] : "",
        description: (snapshot.data()["Instructions"] != null)
            ? snapshot.data()["Instructions"]
            : "No Instructions.",
        order: (snapshot.data()["AutoOrder"] != null)
            ? int.parse(snapshot.data()["AutoOrder"])
            : 0,
        pageCode:
            (snapshot.data()["Link"] != null) ? snapshot.data()["Link"] : "");
  }

  static int sortByOrder(ScoringAttribute a, ScoringAttribute b) {
    if (a.order < b.order) return -1;
    if (a.order == b.order)
      return 0;
    else
      return 1;
  }
}

class ScoringGuide extends StatefulWidget {
  final String title;
  final String gameTitle;
  final int order;
  final int numPlayers;
  final DocumentSnapshot snapshot;

  ScoringGuide(
      {Key key,
      String title,
      String gameTitle,
      int numPlayers,
      int order,
      DocumentSnapshot snapshot})
      : this.title = title,
        this.gameTitle = gameTitle,
        this.order = order,
        this.numPlayers = numPlayers,
        this.snapshot = snapshot,
        super(key: key);

  @override
  _ScoringGuideState createState() => _ScoringGuideState();
}

class _ScoringGuideState extends State<ScoringGuide> {
  List<ScoringAttribute> _attributes = [];
  List<List<int>> _playerScores;

  @override
  void initState() {
    buildAttributeList();
    super.initState();
  }

  Future<void> setPlayerScore(
      int player, ScoringAttribute attribute, int value) async {
    setState(() {
      _playerScores[player][attribute.order - 1] = value;
    });
  }

  void buildAttributeList() async {
    widget.snapshot.reference
        .collection('pages')
        .getDocuments()
        .then((documents) {
      if (_attributes.length == 0) {
        documents.documents.forEach((page) async {
          ScoringAttribute newAttribute =
              await ScoringAttribute.fromSnapshot(page);
          setState(() {
            /// TODO: Create a function to build page from model instead of passing in fields.
            _attributes.add(newAttribute);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SharedLogger().noStack.d('Building ScoringGuide!');
    // Build the list of attributes for scoring.
    if (_attributes.length < 1) {
      buildAttributeList();
    }
    _attributes.sort(ScoringAttribute.sortByOrder);

    if (_playerScores == null && _attributes.length > 0) {
      // Build the 2D array of scoring attributes for each player.
      _playerScores = new List<List<int>>(widget.numPlayers);
      // Initialise a normal array to store each players score.
      for (var i = 0; i < _playerScores.length; i++) {
        if (_playerScores[i] == null) {
          _playerScores[i] = List<int>(_attributes.length);
          for (var j = 0; j < _playerScores[i].length; j++) {
            // Initialise all values to 0.
            _playerScores[i][j] = 0;
          }
        }
      }
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
              height: 30,
              width: 70,
              fit: BoxFit.contain,
            ),
            /* Text(
            'Learn to Play',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ), */
          ),
        ),
        body: Stack(fit: StackFit.expand, children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 65,
              decoration: BoxDecoration(color: cardBG),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                child: Container(
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.gameTitle,
                          style: Theme.of(context).textTheme.headline5),
                      Text(widget.title,
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 65.0),
            child: _attributes.length > 0
                ? renderBody(_attributes)
                : Text("Loading..."),
          ),
        ]));
  }

  Widget renderBody(List<ScoringAttribute> attributes) {
    List<Widget> tabBars = [];
    List<Widget> tabViews = [];

    for (var player = 0; player < widget.numPlayers; player++) {
      tabBars.add(Container(
          height: 65,
          child: Tab(
              text: 'Player ${player + 1}', icon: Icon(Icons.person_outline))));
      tabViews.add(Stack(fit: StackFit.expand, children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 60, left: 11, right: 11),
          child: renderPlayerScoring(attributes, player),
        ),
        Align(
            widthFactor: 2,
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 74),
                child: renderTotalScore(player)))
      ]));
    }
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        DefaultTabController(
            length: widget.numPlayers,
            child: Flexible(
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(color: Colors.black45),
                      child: TabBar(tabs: tabBars)),
                  Container(
                      height: MediaQuery.of(context).size.height - 220,
                      child: TabBarView(children: tabViews))
                ],
              ),
            ))
      ],
    );
  }

  Widget renderPlayerScoring(List<ScoringAttribute> attributes, int player) {
    SharedLogger().noStack.d('RenderPlayerScoring: ${player}');
    List<Widget> categoryWidgets = [];
    for (var cat = 0; cat < attributes.length; cat++) {
      categoryWidgets.add(renderScoringCategory(cat, attributes[cat], player));
    }
    return ListView(children: categoryWidgets);
  }

  Widget renderTotalScore(player) {
    int total = _playerScores[player].reduce((a, b) => a + b);
    return Container(
        color: Theme.of(context).accentColor,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text("TOTAL", style: Theme.of(context).textTheme.headline5),
          ),
          Text(total.toString(), style: Theme.of(context).textTheme.headline4)
        ]));
  }

  Widget renderScoringCategory(
      int order, ScoringAttribute attribute, int player) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 9,
          child: Container(
            padding: EdgeInsets.only(top: 6, bottom: 6, right: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 6),
                      child: Text(attribute.title.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .apply(fontSizeDelta: -5)),
                    ),
                    Icon(Icons.help_outline, color: buttonPrimary, size: 18)
                  ]),
                  Text(
                    attribute.description,
                    textAlign: TextAlign.start,
                  )
                ]),
          ),
        ),
/*         NumberPicker.integer(
          listViewWidth: 38,
          itemExtent: 20,
          textStyle: new TextStyle(
              foreground: Paint()..shader = linearTransparentGradient),
          selectedTextStyle: Theme.of(context).textTheme.button.apply(),
          initialValue: 0,
          minValue: 0,
          maxValue: 100,
          step: 1,
          onChanged: (value) => {setPlayerScore(player, attribute, value)},
        ), */
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: SpinBox(
              enableInteractiveSelection: false,
              showCursor: false,
              min: 0,
              max: 99,
              value: 0,
              spacing: 0,
              direction: Axis.vertical,
              incrementIcon: Icon(Icons.add, size: 18),
              decrementIcon: Icon(Icons.remove, size: 18),
              textStyle: TextStyle(fontSize: 22),
              decoration: InputDecoration(isCollapsed: true, isDense: true),
              onChanged: (value) =>
                  {setPlayerScore(player, attribute, value.toInt())},
            ),
          ),
        ),
      ],
    );
  }
}
