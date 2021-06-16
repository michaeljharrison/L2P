// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:L2P/components/bottomNav.dart';
import 'package:L2P/components/drawerNav.dart';
import 'package:L2P/helpers/logger.dart';
import 'package:L2P/models/constants.dart';
import 'package:L2P/models/state.dart/navigation.dart';
import 'package:L2P/screens/settingsScreen.dart';
import 'package:L2P/screens/storeScreen.dart';
import 'package:L2P/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'theme/theme.dart';
import 'screens/libraryScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  mainContext.spy((evt) {
    SharedLogger().noStack.d(evt);
  });

  runApp(
    MultiProvider(
      providers: [
        Provider<Navigation>(create: (_) => Navigation()),
      ],
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
              title: 'Learn2Play', theme: themeDefault, home: SplashScreen());
          ;
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              title: 'Learn2Play', theme: themeDefault, home: SplashScreen());
          ;
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
            title: 'Learn2Play', theme: themeDefault, home: SplashScreen());
        ;
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width >= Breakpoints.maxPhoneWidth) {
      // Tablet
      return MaterialApp(
        title: 'L2P',
        theme: themeDefault,
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: new LibraryScreen(),
                drawer: DrawerNav(),
              ),
          '/settings': (context) => SettingsScreen(),
          '/store': (context) => StoreScreen(),
        },
      );
    } else {
      // Mobile
      return MaterialApp(
        title: 'L2P',
        theme: themeDefault,
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: new LibraryScreen(),
              bottomNavigationBar: BottomNav()),
          '/settings': (context) => SettingsScreen(),
          '/store': (context) => StoreScreen(),
        },
      );
    }
  }
}
