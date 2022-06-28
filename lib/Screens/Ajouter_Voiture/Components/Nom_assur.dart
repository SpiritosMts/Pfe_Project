import 'package:flutter/material.dart';

class Nom_Assur extends StatefulWidget {
  const Nom_Assur({Key? key}) : super(key: key);

  @override
  State<Nom_Assur> createState() => _Nom_AssurState();
}

class _Nom_AssurState extends State<Nom_Assur> {
  final nomassurancecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: nomassurancecontroller,
        decoration: InputDecoration(labelText: "Nom Assurance"),
      ),
    );
  }
}
