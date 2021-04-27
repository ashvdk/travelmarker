import 'package:flutter/material.dart';
import 'package:travelpointer/components/signinwithfacebook.dart';
import 'package:travelpointer/components/signinwithgoogle.dart';
import 'package:travelpointer/components/signinwithtwitter.dart';
import 'package:travelpointer/screens/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRegisteration extends StatefulWidget {
  final Function setUser;

  const UserRegisteration({Key key, this.setUser}) : super(key: key);
  @override
  _UserRegisterationState createState() => _UserRegisterationState();
}

class _UserRegisterationState extends State<UserRegisteration> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [SignInWithGoogle(setUser: widget.setUser)],
        ),
      ),
    );
  }
}
