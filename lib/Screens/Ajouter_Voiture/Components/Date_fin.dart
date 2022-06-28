import 'package:flutter/material.dart';

class Date_Fin extends StatefulWidget {
  const Date_Fin({Key? key}) : super(key: key);

  @override
  State<Date_Fin> createState() => _Date_FinState();
}

class _Date_FinState extends State<Date_Fin> {
  final datefincontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: datefincontroller,
        decoration: InputDecoration(labelText: "Date Fin Contrat"),
      ),
    );
  }
}
