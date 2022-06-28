import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:changel/Screens/login/login.dart';

class RateButton extends StatefulWidget {
  const RateButton({Key? key}) : super(key: key);

  @override
  State<RateButton> createState() => _RateButtonState();
}

class _RateButtonState extends State<RateButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: FlatButton(
        onPressed: () => {
          Fluttertoast.showToast(
              msg: "Merci",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0),
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
          child: Text(
            "Évaluer",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
