import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FeedScreen extends StatefulWidget {
  final Function setUser;

  const FeedScreen({Key key, this.setUser}) : super(key: key);
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userregistered');
    widget.setUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome to homepage'),
          SizedBox(
            height: 10.0,
          ),
          FlatButton(
            color: Colors.redAccent,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            splashColor: Colors.blueAccent,
            height: 60.0,
            onPressed: () {
              signOutGoogle();
            },
            child: Text("LOGOUT"),
          )
        ],
      ),
    );
  }
}
