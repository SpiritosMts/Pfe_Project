import 'package:flutter/material.dart';

class Log extends StatefulWidget {
  const Log({Key? key}) : super(key: key);

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 80),
      child: Text(
        "Se Connecter",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 36),
        textAlign: TextAlign.left,
      ),
    );
  }
}
