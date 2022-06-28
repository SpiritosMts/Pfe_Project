import 'package:flutter/material.dart';

class Matricule extends StatefulWidget {
  const Matricule({Key? key}) : super(key: key);

  @override
  State<Matricule> createState() => _MatriculeState();
}

class _MatriculeState extends State<Matricule> {
  final matriculecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: matriculecontroller,
        decoration: InputDecoration(labelText: "Matricule"),
      ),
    );
  }
}
