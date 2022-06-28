import 'package:flutter/material.dart';

class Modele extends StatefulWidget {
  const Modele({Key? key}) : super(key: key);

  @override
  State<Modele> createState() => _ModeleState();
}

class _ModeleState extends State<Modele> {
  final modelecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: modelecontroller,
        decoration: InputDecoration(labelText: "Modele"),
      ),
    );
  }
}
