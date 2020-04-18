// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:L2P/components/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
// import 'package:firebase/firebase.dart' as Firebase;
import 'theme/theme.dart';
import 'screens/libraryScreen.dart';

void main() {
/*   if (Firebase.apps.isEmpty) {
    Firebase.initializeApp(
      apiKey: 'AIzaSyBJbFtUL95rKri_xd-_EZtKEf7xlNc0-Jk',
      authDomain: 'learn2play.firebaseapp.com',
      databaseURL: 'https://learn2play.firebaseio.com',
      projectId: 'learn2play',
      storageBucket: 'learn2play.appspot.com',
      appId: '1:223295580147:web:9c92f61ac05e2acf471486',
    );
  } */
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'L2P',
        theme: themeDefault,
        home: new SplashScreen(
            seconds: 0,
            navigateAfterSeconds: new HomePage(),

            /// TODO: Replace with a text style from theme.
            title: new Text('L2P',
                style: TextStyle(
                  color: buttonSecondary,
                  fontWeight: FontWeight.w300,
                  fontSize: 74,
                )),
            // image: new Image.asset(''),
            backgroundColor: systemBG,
            // photoSize: 100.0,
            /// TODO: Replace with a text style from theme.
            loadingText: new Text('Unboxing...',
                style: TextStyle(
                  color: buttonSecondary,
                  fontWeight: FontWeight.w300,
                  fontSize: 26,
                )),
            loaderColor: buttonSecondary));
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
          body: new LibraryScreen(),
          bottomNavigationBar: BottomNav()),
    );
  }
}
