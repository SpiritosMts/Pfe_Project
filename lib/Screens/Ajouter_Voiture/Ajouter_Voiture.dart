import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:changel/Screens/Home/Home.dart';
import 'package:changel/components/background.dart';

import 'Components/AjouterButton.dart';
import 'Components/Annuler.dart';
import 'Components/Couleur.dart';
import 'Components/Date_debut.dart';
import 'Components/Date_fin.dart';
import 'Components/Matricule.dart';
import 'Components/Modele.dart';
import 'Components/Nom_assur.dart';
import 'Components/Num_assur.dart';

class Ajouter_Voitture extends StatefulWidget {
  const Ajouter_Voitture({Key? key}) : super(key: key);

  @override
  State<Ajouter_Voitture> createState() => _Ajouter_VoittureState();
}

class _Ajouter_VoittureState extends State<Ajouter_Voitture> {
  final couleurcontroller = TextEditingController();
  final datedebutcontroller = TextEditingController();
  final datefincontroller = TextEditingController();
  final matriculecontroller = TextEditingController();
  final modelecontroller = TextEditingController();
  final nomassurancecontroller = TextEditingController();
  final numassurancecontroller = TextEditingController();
  CollectionReference carColl = FirebaseFirestore.instance.collection('Voitures');

  final databaserf = FirebaseDatabase.instance.reference();
  Future<void> addCar()async {
    if (modelecontroller.text.isNotEmpty &&
        matriculecontroller.text.isNotEmpty &&
        couleurcontroller.text.isNotEmpty &&
        nomassurancecontroller.text.isNotEmpty &&
        numassurancecontroller.text.isNotEmpty &&
        datedebutcontroller.text.isNotEmpty &&
        datefincontroller.text.isNotEmpty)
    {
      carColl.add({
        'couleur': couleurcontroller.text,
        'modele': modelecontroller.text,
        'matricule': matriculecontroller.text,
        'nomassurance': nomassurancecontroller.text,
        'numassurance': numassurancecontroller.text,
        'datedebut': datedebutcontroller.text,
        'datefin': datefincontroller.text,
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


  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Background(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Veuillez Remplir les champs",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 36),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: size.height * 0.002),
            TextField(
              controller: modelecontroller,
              decoration: InputDecoration(labelText: "Modele"),
            ),
            SizedBox(height: size.height * 0.002),
            TextField(
              controller: matriculecontroller,
              decoration: InputDecoration(labelText: "Matricule"),
            ),
            SizedBox(height: size.height * 0.002),
            TextField(
              controller: couleurcontroller,
              decoration: InputDecoration(labelText: "Couleur"),
            ),
            SizedBox(height: size.height * 0.002),
            TextField(
              controller: nomassurancecontroller,
              decoration: InputDecoration(labelText: "Nom Assurance"),
            ),
            SizedBox(height: size.height * 0.002),
            TextField(
              controller: numassurancecontroller,
              decoration: InputDecoration(labelText: "Num Assurance"),
            ),
            SizedBox(height: size.height * 0.002),
            TextField(
              controller: datedebutcontroller,
              decoration: InputDecoration(labelText: "Date Debut Contrat"),
            ),
            SizedBox(height: size.height * 0.002),
            TextField(
              controller: datefincontroller,
              decoration: InputDecoration(labelText: "Date Fin Contrat"),
            ),
            SizedBox(height: size.height * 0.002),
            Padding(padding: EdgeInsets.all(5)),
            Row(children: [
              Padding(padding: EdgeInsets.all(5)),
              Expanded(
                child: RaisedButton(
                  onPressed: () => {
                    addCar(),

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
                      "Ajouter",
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()))
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
          ],
        ),
      ),
    ));
  }


}
