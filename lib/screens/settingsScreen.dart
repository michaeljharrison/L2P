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
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24, top: 24),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
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
              ),
              Container(
                child: Text(
                  "Note: Please do not activate debug mode unless you’ve been asked to do so! Doing so will activate content and features that are not currently working, and may cause your app to behave strangely.",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNav());
  }
}
