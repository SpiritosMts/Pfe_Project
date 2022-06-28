import 'package:flutter/material.dart';

class Prenom extends StatefulWidget {
  const Prenom({Key? key}) : super(key: key);

  @override
  State<Prenom> createState() => _PrenomState();
}

class _PrenomState extends State<Prenom> {
  final prenomcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: prenomcontroller,
        decoration: InputDecoration(labelText: "Prenom"),
      ),
    );
  }
}
