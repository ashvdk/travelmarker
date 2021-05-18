import 'package:flutter/material.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SignInWithGoogle extends StatelessWidget {
  final storage = new FlutterSecureStorage();
  final Function setUser;
  final Function setLoading;
  SignInWithGoogle({this.setUser, this.setLoading});
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
    await GoogleSignIn().signOut();
    await storage.deleteAll();
    setUser();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: FlatButton(
            color: Color(0xFF05a859),
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            splashColor: Colors.blueAccent,
            height: 80.0,
            onPressed: () {
              setLoading();
              signInWithGoogle().then((value) async {
                // await storage.write(key: "userregistered", value: "no");
                // setUser();
                var token =
                    await FirebaseAuth.instance.currentUser.getIdToken(true);
                var value = FirebaseAuth.instance.currentUser;

                http.Response response = await RestAPI()
                    .getTheRequest('getuserdetails/${value.uid}', token);

                if (response.statusCode == 200) {
                  var checkusername = jsonDecode(response.body);
                  if (checkusername['message'] == "NO_USERNAME_FOUND") {
                    storage.write(key: "userregistered", value: "no");
                  } else {
                    storage.write(key: "userregistered", value: "yes");
                  }
                  setLoading();
                  setUser();
                }
              });
            },
            child: Text(
              "Sign in with Google",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
        Positioned(
          top: 20.0,
          left: 70.0,
          child: Image.asset(
            'assets/googleimage.png',
            width: 40.0,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
