import 'package:flutter/material.dart';

import 'package:changel/Screens/Change_Pass/components/Ancien_mdp.dart';
import 'package:changel/Screens/Change_Pass/components/Change_pass.dart';
import 'package:changel/Screens/Change_Pass/components/Confirmer_mdp.dart';
import 'package:changel/Screens/Change_Pass/components/nouveau_mdp.dart';
import 'package:changel/components/background.dart';
import 'package:changel/widget/navigation_drawer_widget.dart';

class Mot_de_passePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Mot_de_passe'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Change_pass(),
            SizedBox(height: size.height * 0.03),
            ancien_mdp(),
            SizedBox(height: size.height * 0.02),
            nouveau_mdp(),
            SizedBox(height: size.height * 0.01),
            Confirmer_Mdp(),
          ],
        ),
      ),
    );
  }
}
