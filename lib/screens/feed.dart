import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FeedScreen extends StatefulWidget {
  final Function setUser;

  const FeedScreen({Key key, this.setUser}) : super(key: key);
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final storage = new FlutterSecureStorage();
  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await storage.deleteAll();
    widget.setUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Welcome to homepage'),
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
