import 'package:flutter/material.dart';
import 'package:travelpointer/screens/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInWithFacebook extends StatefulWidget {
  @override
  _SignInWithFacebookState createState() => _SignInWithFacebookState();
}

class _SignInWithFacebookState extends State<SignInWithFacebook> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.deepPurple,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.blueAccent,
      height: 60.0,
      onPressed: () {},
      child: Text("LOGIN WITH FACEBOOK"),
    );
  }
}
