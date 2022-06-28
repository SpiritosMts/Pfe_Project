import 'package:flutter/material.dart';


import '../Screens/DeconnectionSc/Components/Dec_Button.dart';
import '../Screens/DeconnectionSc/Components/SeDec.dart';
import '../components/background.dart';
import '../widget/navigation_drawer_widget.dart';

class DeconnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Deconnection'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SeDec(),
            SizedBox(height: size.height * 0.05),
            Dec_Button(),
          ],
        ),
      ),
    );
  }
}
