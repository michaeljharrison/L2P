// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'components/section.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: defaultTheme,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Star Realms',
            style: titleStyle,
          ),
        ),
        body: Center(
          child: Padding(padding: EdgeInsets.all(10), child: Section()),
        ),
      ),
    );
  }
}
