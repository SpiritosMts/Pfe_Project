import 'package:flutter/material.dart';

class Date_Debut extends StatefulWidget {
  const Date_Debut({Key? key}) : super(key: key);

  @override
  State<Date_Debut> createState() => _Date_DebutState();
}

class _Date_DebutState extends State<Date_Debut> {
  final datedebutcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: datedebutcontroller,
        decoration: InputDecoration(labelText: "Date Debut Contrat"),
      ),
    );
  }
}
