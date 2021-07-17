import 'package:flutter/material.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignInWithGoogle extends StatefulWidget {
  final Function setUser;

  final bool disablesigninwithgooglebutton;
  final Function doyouwanttodisbaleloginorcreate;
  SignInWithGoogle(
      {this.setUser,
      this.disablesigninwithgooglebutton,
      this.doyouwanttodisbaleloginorcreate});

  @override
  _SignInWithGoogleState createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  bool signInLoading = false;
  var message = '';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userregistered');
    widget.setUser();
  }

  @override
  Widget build(BuildContext context) {
    return signInLoading
        ? CircularProgressIndicator(
            backgroundColor: Colors.white,
          )
        : Column(
            children: [
              Text(
                "$message",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Image.asset(
                      'assets/googleimage.png',
                      width: 40.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
                onPressed: () async {
                  if (!widget.disablesigninwithgooglebutton) {
                    widget.doyouwanttodisbaleloginorcreate();
                    setState(() {
                      signInLoading = true;
                    });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('userregistered', "error");
                    signInWithGoogle().then((value) async {
                      // await storage.write(key: "userregistered", value: "no");
                      // setUser();
                      var token = await FirebaseAuth.instance.currentUser
                          .getIdToken(true);
                      var value = FirebaseAuth.instance.currentUser;

                      try {
                        http.Response response = await RestAPI().getTheRequest(
                            'getuserdetails/${value.uid}', token);

                        if (response.statusCode == 200) {
                          var checkusername = jsonDecode(response.body);
                          if (checkusername['message'] == "NO_USERNAME_FOUND") {
                            prefs.setString('userregistered', "no");
                            //storage.write(key: "userregistered", value: "no");
                          } else {
                            prefs.setString('userregistered', "yes");
                            //storage.write(key: "userregistered", value: "yes");
                          }
                          widget.setUser();
                        }
                      } catch (e) {
                        signOutGoogle();
                      }
                    }).catchError((onError) {
                      setState(() {
                        message = onError.toString();
                        signInLoading = false;
                      });
                      print(onError.toString());
                    });
                  }
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(MediaQuery.of(context).size.width, 80),
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  backgroundColor: Colors.green,
                ),
              )
            ],
          );
  }
}
