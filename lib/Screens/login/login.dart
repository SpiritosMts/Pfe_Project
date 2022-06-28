import 'package:changel/provider/navigation_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:changel/Screens/Forgot_Password/Forgot_password.dart';
import 'package:changel/Screens/Home/Home.dart';
import 'package:changel/Screens/signup/signup.dart';
import 'package:changel/components/background.dart';
import 'package:changel/main.dart';
import 'package:changel/page/Acceuil.dart';
import 'package:provider/provider.dart';

import '../../Models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final usersColl = FirebaseFirestore.instance.collection('app_users');

  get grayshade => null;
  isCheck() => null;
  get whiteshade => null;
  get blue => null;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void selectUser(BuildContext context, AppUser usr) {
    final provider = Provider.of<NavigationProviderUser>(context, listen: false);
    provider.setCurrentUser(usr);
  }

  Future<void> getUserInfo(userEmail)async{
    AppUser currentUser = AppUser();

    currentUser.email = FirebaseAuth.instance.currentUser!.email!;
    await usersColl.where('email', isEqualTo:userEmail).get().then((event) {
      print('### user found in Cloud');

      var userDoc = event.docs.single;
      currentUser.name= userDoc.get('name');
      currentUser.id= userDoc.get('id');
      currentUser.address= userDoc.get('address');
      currentUser.phone= userDoc.get('phone');
      currentUser.pwd= userDoc.get('password');
      currentUser.isChan= userDoc.get('isChan');

     // print('######## ${currentUser.address} ${currentUser.name} ${currentUser.phone} ${currentUser.email} ');

      /// select curr user with provider
      selectUser(context,currentUser);


    }).catchError((e) => print("error while loading user info: $e"));
  }

  void Login(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        //get current user info
        await getUserInfo(email).then((value) {
          ///Success Login

          Fluttertoast.showToast(
              msg: "Bienvenue",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
          );

        }).then((value) =>null).catchError((e){
          Fluttertoast.showToast(
              msg: "user-not-found in cloud",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        });


      } on FirebaseAuthException catch (e) {
        print('error = ${e.message}');
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(
              msg: "user-not-found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);

          print('user not found');
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(
              msg: "wrong-password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);

          print('wrong password');
        }
      }catch (e) {
        print('exeption in login user auth: $e');
      }
    }
    //navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Image.asset("assets/images/ca.png",
                              width: size.width),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        /// email
                        TextField(
                          controller: emailcontroller,
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        /// password
                        TextField(
                          controller: passwordcontroller,
                          decoration: InputDecoration(labelText: "Mot De Passe"),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        /// forgot password
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()
                                )
                            )
                          },
                          child: Text(
                            "Mot De Passe Oublié?",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2661FA)),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(children: [
                          Padding(padding: EdgeInsets.all(5)),
                          /// Sign up
                          Expanded(
                            child: RaisedButton(
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupScreen())
                                )
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
                                  "S'inscrire",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          /// sign in
                          Expanded(
                            child: RaisedButton(
                              onPressed: () => {
                               Login(emailcontroller.text,passwordcontroller.text)
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
                                  "Se Connecter",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                        ]),
                      ],
                    ),
                  ),
                ))));
  }


}
