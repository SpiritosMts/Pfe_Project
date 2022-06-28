import 'package:flutter/material.dart';

class Nom extends StatefulWidget {
  const Nom({Key? key}) : super(key: key);

  @override
  State<Nom> createState() => _NomState();
}

class _NomState extends State<Nom> {
  final nomcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: nomcontroller,
        decoration: InputDecoration(labelText: "Nom"),
      ),
    );
  }
}
