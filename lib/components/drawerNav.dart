import 'package:L2P/components/bottomNav.dart';
import 'package:flutter/material.dart';

class DrawerNav extends StatefulWidget {
  DrawerNav({Key key}) : super(key: key);

  @override
  _DrawerNavState createState() => _DrawerNavState();
}

class _DrawerNavState extends State<DrawerNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final NavigationArguments navArgs =
        ModalRoute.of(context).settings.arguments;
    if (navArgs != null) {
      switch (navArgs.screen) {
        case Enum_Screens.library:
          _selectedIndex = 0;
          break;
        case Enum_Screens.settings:
          _selectedIndex = 1;
          break;
        case Enum_Screens.store:
          _selectedIndex = 2;
          break;

        default:
      }
    }

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).highlightColor),
            child: Text('Learn2Play'),
          ),
          ListTile(
            title: Text('Library'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/',
                  arguments: NavigationArguments(Enum_Screens.library));
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/settings',
                  arguments: NavigationArguments(Enum_Screens.settings));
            },
          ),
        ],
      ),
    );
  }
}
