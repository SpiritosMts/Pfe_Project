import 'package:flutter/material.dart';

class LearnMore extends StatefulWidget {
  const LearnMore({Key? key}) : super(key: key);

  @override
  State<LearnMore> createState() => _LearnMoreState();
}

class _LearnMoreState extends State<LearnMore> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: GestureDetector(
        child: Text(
          "Learn more",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2661FA)),
        ),
      ),
    );
  }
}
