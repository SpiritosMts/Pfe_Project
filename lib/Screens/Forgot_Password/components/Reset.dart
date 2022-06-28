import 'package:flutter/material.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      child: Text(
        "Restaurez Votre Mot De Passe",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 46),
        textAlign: TextAlign.left,
      ),
    );
  }
}
