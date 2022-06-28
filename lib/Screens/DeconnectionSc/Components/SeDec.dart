import 'package:flutter/material.dart';

class SeDec extends StatefulWidget {
  const SeDec({Key? key}) : super(key: key);

  @override
  State<SeDec> createState() => _SeDecState();
}

class _SeDecState extends State<SeDec> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      child: Text(
        "Voulez-Vous Vraiement Se Deconnecter?",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 46),
        textAlign: TextAlign.left,
      ),
    );
  }
}
