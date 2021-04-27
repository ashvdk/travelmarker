import 'package:flutter/material.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
              signInWithGoogle().then((value) async {
                FirebaseAuth.instance.currentUser
                    .getIdToken(true)
                    .then((token) async {
                  var body = {
                    "uid": value.user.uid,
                    "email": value.user.email,
                    "displayName": value.user.displayName
                  };
                  http.Response response =
                      await RestAPI().postTheRequest('user', body, token);
                  if (response.statusCode == 200) {
                    setUser();
                  } else {
                    signOutGoogle().then((value) => setUser());
                  }
                });
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
