import 'package:flutter/material.dart';

import 'package:changel/Screens/Home/Home.dart';

class Annuler_button extends StatefulWidget {
  const Annuler_button({Key? key}) : super(key: key);

  @override
  State<Annuler_button> createState() => _Annuler_buttonState();
}

class _Annuler_buttonState extends State<Annuler_button> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: RaisedButton(
        onPressed: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()))
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
