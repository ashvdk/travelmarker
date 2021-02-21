import 'package:flutter/material.dart';
import 'package:travelpointer/screens/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class SignInWithGoogle extends StatelessWidget {
  final Function setUser;
  SignInWithGoogle({this.setUser});
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();

    print("User Signed Out");
    print(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.redAccent,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.blueAccent,
      height: 60.0,
      onPressed: () {
        signInWithGoogle().then((value) async {
          FirebaseAuth.instance.currentUser
              .getIdToken(true)
              .then((token) async {
            http.Response response =
                await http.post('http://192.168.0.7:6000/user', body: {
              "uid": value.user.uid,
              "email": value.user.email,
              "displayName": value.user.displayName
            }, headers: {
              HttpHeaders.authorizationHeader: token
            });
            if (response.statusCode == 200) {
              setUser();
            } else {
              signOutGoogle().then((value) => setUser());
            }
          });
        });
      },
      child: Text("LOGIN WITH GOOGLE"),
    );
  }
}
