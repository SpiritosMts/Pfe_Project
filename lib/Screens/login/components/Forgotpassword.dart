import 'package:flutter/material.dart';
import 'package:changel/Screens/Forgot_Password/Forgot_password.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({key}) : super(key: key);

  @override
  State<Forgotpass> createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: GestureDetector(
        onDoubleTap: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ForgotPassword()))
        },
        child: Text(
          "Mot De Passe Oublié?",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2661FA)),
        ),
      ),
    );
  }
}
