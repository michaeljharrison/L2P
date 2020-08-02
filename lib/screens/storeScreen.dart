import 'package:L2P/components/bottomNav.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({Key key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
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
        body: Text("Store"),
        bottomNavigationBar: BottomNav());
  }
}
