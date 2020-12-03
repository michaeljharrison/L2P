// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:L2P/components/bottomNav.dart';
import 'package:L2P/screens/settingsScreen.dart';
import 'package:L2P/screens/storeScreen.dart';
import 'package:L2P/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'theme/theme.dart';
import 'screens/libraryScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Learn2Play',
        theme: themeDefault,
        home:
            SplashScreen() /* new SplashScreen(
            seconds: 3,
            navigateAfterSeconds: new HomePage(),

            /// TODO: Replace with a text style from theme.
            photoSize: 50,
            image: new Image.asset(
              'icons/Logo.png',
            ),
            //backgroundColor: systemBG,
            gradientBackground: backgroundBlueGradient,
            // photoSize: 100.0,
            /// TODO: Replace with a text style from theme.
            loadingText: new Text('Unboxing...',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
            loaderColor: Colors.white) */
        );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'L2P',
      theme: themeDefault,
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
/*             appBar: PreferredSize(
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
            ), */
            body: new LibraryScreen(),
            bottomNavigationBar: BottomNav()),
        '/settings': (context) => SettingsScreen(),
        '/store': (context) => StoreScreen(),
      },
    );
  }
}
