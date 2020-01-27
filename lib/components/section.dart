import 'package:flutter/material.dart';

class SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              child: Padding(
            padding: EdgeInsets.only(right: 15),
            child:
                Container(width: 50, color: Colors.grey[50], child: Text("A")),
          )),
          Container(
              child: Expanded(
                  child: Container(
            color: Colors.black,
            child: Text("B"),
          )))
        ],
      ),
    );
  }
}

class Section extends StatefulWidget {
  @override
  SectionState createState() => SectionState();
}
