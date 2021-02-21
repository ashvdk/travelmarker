import 'package:flutter/material.dart';
import 'package:travelpointer/screens/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninWithTwitter extends StatefulWidget {
  @override
  _SigninWithTwitterState createState() => _SigninWithTwitterState();
}

class _SigninWithTwitterState extends State<SigninWithTwitter> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.lightBlueAccent,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.blueAccent,
      height: 60.0,
      onPressed: () {},
      child: Text("LOGIN WITH TWITTER"),
    );
  }
}
