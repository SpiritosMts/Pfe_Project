import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:changel/Screens/login/login.dart';
import 'package:provider/provider.dart';

import '../../../Models/navigation_item.dart';
import '../../../provider/navigation_provider.dart';

class Dec_Button extends StatefulWidget {
  const Dec_Button({Key? key}) : super(key: key);

  @override
  State<Dec_Button> createState() => _Dec_ButtonState();
}

class _Dec_ButtonState extends State<Dec_Button> {
  @override
  final _auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RaisedButton(
      /// on disconnect
      onPressed: () => {
        _auth.signOut(),
        Fluttertoast.showToast(
            msg: "Au revoir ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0),
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()))
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      textColor: Colors.white,
      padding: const EdgeInsets.all(0),
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        width: size.width * 0.5,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          color: Colors.black,
        ),
        padding: const EdgeInsets.all(0),
        child: Text(
          "Se Deconnecter",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
