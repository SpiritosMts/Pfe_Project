import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Screens/Ajouter_Depanneur/Ajouter_Depanneur.dart';
import '../widget/navigation_drawer_widget.dart';

class Mes_depanneursPage extends StatefulWidget {


  @override
  State<Mes_depanneursPage> createState() => _Mes_depanneursPageState();
}

class _Mes_depanneursPageState extends State<Mes_depanneursPage> {
  CollectionReference  collectionusers = FirebaseFirestore.instance.collection('Mes_depanneurs');

  Future<void> removeDep (String id){

    return collectionusers
        .doc(id)
        .delete()
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Text('depanneur supprimé'),
        )))

        .catchError((error) => print("Failed to delete depanneur: $error"));

  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {


    return snapshot.data!.docs
        .map((doc) =>  Card(

      margin: const EdgeInsets.all(8.0),

      elevation: 10,
      child: ListTile(
          title:  Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 3.0),

            child: Text(doc["date"],
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 3.0),
            child: Text('Distance parcourue: ${doc['distance']}\nCoût: ${doc['cout']}\nRaison: ${doc['raison']}'),
          ),
          trailing: IconButton(
            onPressed: () {
              removeDep(doc.id);
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
          title: Text('Historique'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body:  Padding(
          padding: const EdgeInsets.all(15),

          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Mes_depanneurs").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
                  return  ListView(children: getExpenseItems(snapshot));

                }
                else if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else return  Center(child: Text("Ajouter des depanneurs",
                  style: TextStyle(
                    fontSize: 24,
                  ),),);

              }
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Ajouter_Dep()))
          },
          child: const Icon(Icons.add),
        ),
      );
}
