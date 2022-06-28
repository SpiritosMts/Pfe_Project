import 'package:flutter/material.dart';

class Chekbox extends StatefulWidget {
  const Chekbox({Key? key}) : super(key: key);

  @override
  State<Chekbox> createState() => _ChekboxState();
}

class _ChekboxState extends State<Chekbox> {
  bool isRememberMe = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Checkbox(
          value: isRememberMe,
          checkColor: Colors.blue,
          activeColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              isRememberMe = value!;
            });
          },
        ),
      ),
    );
  }
}
