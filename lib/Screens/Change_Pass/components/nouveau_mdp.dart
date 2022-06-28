import 'package:flutter/material.dart';

class nouveau_mdp extends StatefulWidget {
  const nouveau_mdp({Key? key}) : super(key: key);

  @override
  State<nouveau_mdp> createState() => _nouveau_mdpState();
}

class _nouveau_mdpState extends State<nouveau_mdp> {
  final nouveaumdpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: nouveaumdpcontroller,
        decoration: InputDecoration(labelText: "Nouveau Mot De Passe"),
      ),
    );
  }
}
