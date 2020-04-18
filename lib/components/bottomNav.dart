import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

class BottomNav extends StatelessWidget {
  const BottomNav() : super();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 110,
            padding:
                const EdgeInsets.only(top: 15, bottom: 25, left: 55, right: 55),
            child: Container(
              decoration: BoxDecoration(
                color: colorBottomNav,
                borderRadius: BorderRadius.circular(50),
              ),
            )),
        Container(
            height: 110,
            padding: const EdgeInsets.only(left: 55, right: 55),
            child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: colorTransparent,
                    items: [
                      new BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        title: new Text(
                          'LIBRARY',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        title: new Text(
                          'STORE',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        title: new Text(
                          'SETTINGS',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ])))
      ],
    );
  }
}
