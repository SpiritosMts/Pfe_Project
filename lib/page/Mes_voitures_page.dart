import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Screens/Ajouter_Voiture/Ajouter_Voiture.dart';
import '../widget/navigation_drawer_widget.dart';

class Mes_voituresPage extends StatefulWidget {

  @override
  State<Mes_voituresPage> createState() => _Mes_voituresPageState();
}

class _Mes_voituresPageState extends State<Mes_voituresPage> {
  CollectionReference  collectionusers = FirebaseFirestore.instance.collection('Voitures');

  Future<void> removeCar (String id){

    return collectionusers
        .doc(id)
        .delete()
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Text('voiture supprimé'),
        )))

        .catchError((error) => print("Failed to delete car: $error"));

  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {


    return snapshot.data!.docs
        .map((doc) =>  Card(

      margin: const EdgeInsets.all(8.0),

      elevation: 10,
      child: ListTile(
          title:  Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 3.0),

            child: Text(doc["modele"],
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 3.0),
            child: Text('couleur: ${doc['couleur']}\nassurance: ${doc['nomassurance']}\nmatricule: ${doc['matricule']}\ndatedebut: ${doc['datedebut']}\ndatefin: ${doc['datefin']}'),
          ),
          trailing: IconButton(
            onPressed: () {
              removeCar(doc.id);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
      ),
    ))
        .toList();


  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Mes_voitures'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body:   Padding(
          padding: const EdgeInsets.all(15),

          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Voitures").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
                  return  ListView(children: getExpenseItems(snapshot));

                }
                else if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else return  Center(child: Text("Ajouter des voitures",
                    style: TextStyle(
                      fontSize: 24,
                    ),),);

              }
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Ajouter_Voitture()))
          },
          child: const Icon(Icons.add),
        ),
      );
}
