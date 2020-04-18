import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

class BottomNav extends StatelessWidget {
  const BottomNav() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 11, left: 55, right: 55),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: colorBottomNav, borderRadius: BorderRadius.circular(50)),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
            child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 10,
                        ),
                        Text(
                          'LIBRARY',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 10,
                        ),
                        Text(
                          'STORE',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 10,
                        ),
                        Text(
                          'SETTINGS',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
