import 'package:flutter/material.dart';

class Couleur extends StatefulWidget {
  const Couleur({Key? key}) : super(key: key);

  @override
  State<Couleur> createState() => _CouleurState();
}

class _CouleurState extends State<Couleur> {
  final couleurcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: couleurcontroller,
        decoration: InputDecoration(labelText: "Couleur"),
      ),
    );
  }
}
