import 'dart:developer';

import 'package:L2P/components/bottomNav.dart';
import 'package:L2P/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool debugOn;

  Future<bool> getDebugOn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool debugOnPref = prefs.getBool(Settings.debugOn);
    setState(() {
      debugOn = debugOnPref;
    });
    return debugOnPref;
  }

  Future<bool> setDebugOn(bool newValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      debugOn = newValue;
    });
    return prefs.setBool(Settings.debugOn, newValue);
  }

  @override
  void initState() {
    super.initState();
    getDebugOn();
  }

  @override
  Widget build(BuildContext context) {
    log(debugOn.toString());
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Settings',
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          children: <Widget>[
            Text("Settings"),
            GestureDetector(
              onTap: () {
                log("Tapped.");
                setDebugOn(debugOn ? false : true);
              },
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Debug Mode"),
                  Switch(
                      value: (debugOn == null) ? false : debugOn,
                      onChanged: (bool newState) {
                        setDebugOn(newState);
                      })
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNav());
  }
}
