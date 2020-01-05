// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'theme/theme.dart';
import 'screens/library.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'L2P',
        theme: themeDefault,
        home: new SplashScreen(
            seconds: 2,
            navigateAfterSeconds: new HomePage(),
            title: new Text('L2P',
                style: TextStyle(
                  color: colorTealPrimary,
                  fontWeight: FontWeight.w300,
                  fontSize: 74,
                )),
            // image: new Image.asset(''),
            backgroundColor: colorBGDark,
            // photoSize: 100.0,
            loadingText: new Text('Unboxing...',
                style: TextStyle(
                  color: colorTealPrimary,
                  fontWeight: FontWeight.w300,
                  fontSize: 26,
                )),
            loaderColor: colorTealPrimary));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'L2P',
      theme: themeDefault,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Learn to Play',
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
        ),
        body: new Library(),
      ),
    );
  }
}