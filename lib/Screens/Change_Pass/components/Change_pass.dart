import 'package:flutter/material.dart';

class Change_pass extends StatefulWidget {
  const Change_pass({Key? key}) : super(key: key);

  @override
  State<Change_pass> createState() => _Change_passState();
}

class _Change_passState extends State<Change_pass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 80),
      child: Text(
        "Changez Votre Mot de Passe?",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 36),
        textAlign: TextAlign.left,
      ),
    );
  }
}
