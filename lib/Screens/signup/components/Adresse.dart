import 'package:flutter/material.dart';

class Adresse extends StatefulWidget {
  const Adresse({Key? key}) : super(key: key);

  @override
  State<Adresse> createState() => _AdresseState();
}

class _AdresseState extends State<Adresse> {
  final adressecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: adressecontroller,
        decoration: InputDecoration(labelText: "Adresse"),
      ),
    );
  }
}
