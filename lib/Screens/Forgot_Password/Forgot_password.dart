import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:changel/Screens/login/components/Email.dart';
import 'package:changel/Screens/login/login.dart';
import 'package:changel/components/background.dart';

import 'components/Reset.dart';
import 'components/ResetButton.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailcontroller = TextEditingController();

  Future VerifyEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);
      Fluttertoast.showToast(msg: "Reset email sent");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()
      )
      );
    } on FirebaseAuthException catch (e) {
      print('### Error' +e.message.toString());
    }
  }
 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
              child: Text(
                "Restaurez Votre Mot De Passe",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 46
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(labelText: "Email"),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            /// verify btn
            Expanded(
              child: FlatButton(
                onPressed: VerifyEmail,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
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
                  child: Text(
                    "Restaurer",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
