import 'package:changel/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

import '../components/background.dart';

class aidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Aide'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Background(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text(
              "Vous Avez Un Probleme?",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 28),
              textAlign: TextAlign.left,
            ),
            Text(
              "Contactez Ce Numero ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 28),
              textAlign: TextAlign.left,
            ),
            Text(
              "73700600",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 38),
              textAlign: TextAlign.left,
            ),
          ])));
}
