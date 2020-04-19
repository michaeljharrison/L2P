import 'package:L2P/models/state.dart/navigation.dart';
import 'package:flutter/material.dart';
import 'package:L2P/theme/theme.dart';

enum Enum_Screens { library, store, settings }

class NavigationArguments {
  final Enum_Screens screen;

  NavigationArguments(this.screen);
}

class BottomNav extends StatefulWidget {
  const BottomNav({Key key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/',
              arguments: NavigationArguments(Enum_Screens.library));
          break;
        case 1:
          Navigator.pushNamed(context, '/store',
              arguments: NavigationArguments(Enum_Screens.store));
          break;
        case 2:
          Navigator.pushNamed(context, '/settings',
              arguments: NavigationArguments(Enum_Screens.settings));
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final NavigationArguments navArgs =
        ModalRoute.of(context).settings.arguments;
    if (navArgs != null) {
      switch (navArgs.screen) {
        case Enum_Screens.library:
          _selectedIndex = 0;
          break;
        case Enum_Screens.store:
          _selectedIndex = 1;
          break;
        case Enum_Screens.settings:
          _selectedIndex = 2;
          break;
        default:
      }
    }

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
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.amber[800],
                    onTap: _onItemTapped,
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
