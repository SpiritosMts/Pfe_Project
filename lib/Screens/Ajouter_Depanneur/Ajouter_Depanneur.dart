import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:changel/Screens/login/components/Email.dart';
import 'package:changel/Screens/login/components/Password.dart';
import 'package:changel/Screens/signup/components/Adresse.dart';
import 'package:changel/Screens/signup/components/Prenom.dart';
import 'package:changel/Screens/signup/components/nom.dart';
import 'package:changel/components/background.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Home/Home.dart';
import 'Components/AnnulerButt.dart';
import 'Components/NumTel.dart';
import 'Components/Remplir.dart';
import 'Components/ValiderButt.dart';

class Ajouter_Dep extends StatefulWidget {
  const Ajouter_Dep({Key? key}) : super(key: key);

  @override
  State<Ajouter_Dep> createState() => _Ajouter_DepState();
}

class _Ajouter_DepState extends State<Ajouter_Dep> {

  CollectionReference depanColl = FirebaseFirestore.instance.collection('Mes_depanneurs');
  final nomcontroller = TextEditingController();
  final prenomcontroller = TextEditingController();
  final adressecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final ctrl0 = TextEditingController();
  final ctrl1 = TextEditingController();
  final ctrl2 = TextEditingController();
  final ctrl3 = TextEditingController();
 Future<void> AddDepanneur()async{

    depanColl.add({
      'name': '${nomcontroller.text} ${prenomcontroller.text}' ,
      'email': emailcontroller.text,
      'phone': phonecontroller.text,
      'address': adressecontroller.text,
      'pwd': passwordcontroller.text,
      'date': ctrl0.text,
      'distance': ctrl1.text,
      'cout': ctrl2.text,
      'raison': ctrl3.text,
    }).then((value) async {
      Fluttertoast.showToast(
          msg: "Ajout Avec Succes",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);


    }).catchError((error) {
      print("### Failed to add user to fireStore: $error");
    });
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Veuillez Remplir les champs",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black, fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.002),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: nomcontroller,
              decoration: InputDecoration(labelText: "Nom"),
            ),
          ),
            SizedBox(height: size.height * 0.002),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: prenomcontroller,
              decoration: InputDecoration(labelText: "Prenom"),
            ),
          ),
            SizedBox(height: size.height * 0.002),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: phonecontroller,
              decoration: InputDecoration(labelText: "Numero de telephone"),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: ctrl0,
              decoration: InputDecoration(labelText: "Date de dépannage"),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: ctrl1,
              decoration: InputDecoration(labelText: "Distance parcourue"),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: ctrl2,
              decoration: InputDecoration(labelText: "Coût"),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: ctrl3,
              decoration: InputDecoration(labelText: "raison"),
            ),
          ),
            SizedBox(height: size.height * 0.002),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: adressecontroller,
              decoration: InputDecoration(labelText: "Adresse"),
            ),
          ),
            SizedBox(height: size.height * 0.002),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: emailcontroller,
              decoration: InputDecoration(labelText: "Email"),
            ),
          ),
            SizedBox(height: size.height * 0.002),
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
            onPressed: ()async => {
             await AddDepanneur(),

            },
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
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
                  context, MaterialPageRoute(builder: (context) => MainPage()))
            },
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
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
          ],
        ),
      ),
    );
  }
}
