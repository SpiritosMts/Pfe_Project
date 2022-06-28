import 'package:flutter/material.dart';

class ancien_mdp extends StatefulWidget {
  const ancien_mdp({Key? key}) : super(key: key);

  @override
  State<ancien_mdp> createState() => _ancien_mdpState();
}

class _ancien_mdpState extends State<ancien_mdp> {
  final ancienmdpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: ancienmdpcontroller,
        decoration: InputDecoration(labelText: "Ancien Mot De Passe"),
      ),
    );
  }
}
