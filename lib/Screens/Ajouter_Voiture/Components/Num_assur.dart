import 'package:flutter/material.dart';

class Num_Assur extends StatefulWidget {
  const Num_Assur({Key? key}) : super(key: key);

  @override
  State<Num_Assur> createState() => _Num_AssurState();
}

class _Num_AssurState extends State<Num_Assur> {
  final numassurancecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: numassurancecontroller,
        decoration: InputDecoration(labelText: "Num Assurance"),
      ),
    );
  }
}
