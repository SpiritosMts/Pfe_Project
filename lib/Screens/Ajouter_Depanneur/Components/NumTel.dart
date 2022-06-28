import 'package:flutter/material.dart';

class NumTel extends StatefulWidget {
  const NumTel({Key? key}) : super(key: key);

  @override
  State<NumTel> createState() => _NumTelState();
}

class _NumTelState extends State<NumTel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        decoration: InputDecoration(labelText: "Numero de telephone"),
      ),
    );
  }
}
