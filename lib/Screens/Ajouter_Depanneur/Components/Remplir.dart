import 'package:flutter/material.dart';

class Remplir extends StatefulWidget {
  const Remplir({Key? key}) : super(key: key);

  @override
  State<Remplir> createState() => _RemplirState();
}

class _RemplirState extends State<Remplir> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Veuillez Remplir les champs",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 36),
        textAlign: TextAlign.left,
      ),
    );
  }
}
