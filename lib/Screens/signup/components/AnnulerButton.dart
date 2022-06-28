import 'package:flutter/material.dart';

import 'package:changel/Screens/login/login.dart';

class AnnulerButton extends StatefulWidget {
  const AnnulerButton({Key? key}) : super(key: key);

  @override
  State<AnnulerButton> createState() => _AnnulerButtonState();
}

class _AnnulerButtonState extends State<AnnulerButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: RaisedButton(
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()))
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        textColor: Colors.white,
        padding: const EdgeInsets.all(0),
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: size.width * 0.5,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(80.0),
            color: Colors.black,
          ),
          padding: const EdgeInsets.all(0),
          child: Text(
            "Annuler",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
