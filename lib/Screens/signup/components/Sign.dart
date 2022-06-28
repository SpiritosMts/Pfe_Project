import 'package:flutter/material.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Sign Up",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 36),
        textAlign: TextAlign.left,
      ),
    );
  }
}
