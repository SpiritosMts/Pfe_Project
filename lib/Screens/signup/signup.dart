import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:changel/Screens/Home/Home.dart';

import 'package:changel/Screens/login/components/Email.dart';
import 'package:changel/Screens/login/components/Password.dart';
import 'package:changel/Screens/login/login.dart';
import 'package:changel/Screens/signup/components/Learnmore.dart';
import 'package:changel/Screens/signup/components/Prenom.dart';
import 'package:changel/Screens/signup/components/Sign.dart';
import 'package:changel/components/background.dart';
import 'components/Adresse.dart';
import 'components/AnnulerButton.dart';
import 'components/Validerbutton.dart';
import 'components/nom.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nomcontroller = TextEditingController();
  final prenomcontroller = TextEditingController();
  final adressecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final _auth =FirebaseAuth.instance;
  CollectionReference usersColl = FirebaseFirestore.instance.collection('app_users');

  signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
         await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ).then((value) {

           usersColl.add({
             'name': nomcontroller.text +' '+ prenomcontroller.text,
             'email': emailcontroller.text,
             'password': passwordcontroller.text,
             'address': adressecontroller.text,
             'phone': phonecontroller.text,
             'isChan': 'false',

           }).then((value) async {

             Fluttertoast.showToast(
                 msg: "reconnectez-vous",
                 toastLength: Toast.LENGTH_SHORT,
                 gravity: ToastGravity.CENTER,
                 timeInSecForIosWeb: 1,
                 backgroundColor: Colors.blue,
                 textColor: Colors.white,
                 fontSize: 16.0);

             Navigator.pushReplacement(
               context,
               MaterialPageRoute(
                 builder: (_) => LoginScreen(),
               ),
             );
             String userID = value.id.toString();
             //set id
             usersColl.doc(userID).set({
               'id': userID,
             },
               SetOptions(merge: true),
             );
           }).catchError((error) {
             print("Failed to add User: $error");
           });


         });



      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
              msg: "weak-password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);

          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: "email-already-in-use",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);

          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.002),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      /// name
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: nomcontroller,
                          decoration: InputDecoration(labelText: "Nom"),
                        ),
                      ),
                      /// lastName
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: prenomcontroller,
                          decoration: InputDecoration(labelText: "Prenom"),
                        ),
                      ),
                      SizedBox(height: size.height * 0.002),
                      SizedBox(height: size.height * 0.002),
                      /// email
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: emailcontroller,
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                      ),
                      /// phone
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: phonecontroller,
                          decoration: InputDecoration(labelText: "Phone"),
                        ),
                      ),
                      SizedBox(height: size.height * 0.002),
                      /// address
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: adressecontroller,
                          decoration: InputDecoration(labelText: "Adresse"),
                        ),
                      ),
                      SizedBox(height: size.height * 0.002),
                      SizedBox(height: size.height * 0.002),
                      /// password
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          controller: passwordcontroller,
                          decoration: InputDecoration(labelText: "Mot De Passe"),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: size.height * 0.002),
                      Padding(padding: EdgeInsets.all(5)),
                      Row(children: [
                        Padding(padding: EdgeInsets.all(5)),
                        Expanded(
                          child: RaisedButton(
                            onPressed: (() {
                              signUp(
                                emailcontroller.text,
                                passwordcontroller.text,
                              );
                            }),
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
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                "Valider",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                        Expanded(
                          child: RaisedButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()))
                            },
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
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                "Annuler",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                      ]),
                      Container(
                        alignment: Alignment.centerRight,
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: GestureDetector(
                          child: Text(
                            "Learn more",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2661FA)),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }


}
