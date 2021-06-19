import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:travelpointer/classes/restapi.dart';
import 'dart:convert';

class SigninWithUsernameandPassword extends StatefulWidget {
  final bool chooseloginorcreate;
  final Function setUser;
  SigninWithUsernameandPassword({this.chooseloginorcreate, this.setUser});
  @override
  _SigninWithUsernameandPasswordState createState() =>
      _SigninWithUsernameandPasswordState();
}

class _SigninWithUsernameandPasswordState
    extends State<SigninWithUsernameandPassword> {
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _emailcreate;
  TextEditingController _passwordcreate;
  var emailloginerror = false;
  var passwordloginerror = false;
  var emailcreateerror = false;
  var passwordcreateerror = false;
  var signinerror = false;
  var signinerrormessage;
  var createerror = false;
  var createerrormessage;
  var signinloading = false;
  var createloading = false;
  bool showpasswordforlogin = false;
  bool showpasswordforcreate = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _emailcreate = TextEditingController();
    _passwordcreate = TextEditingController();
  }

  void signin() async {
    if (_email.text.isEmpty) {
      setState(() {
        emailloginerror = true;
      });
      return;
    }
    if (_password.text.isEmpty) {
      setState(() {
        passwordloginerror = true;
      });
      return;
    }
    setState(() {
      emailloginerror = false;
      passwordloginerror = false;
      signinloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userregistered', "error");
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _email.text, password: _password.text)
        .then((value) async {
      setState(() {
        signinerror = false;
        signinerrormessage = "";
      });
      requestuserdetails();
    }).catchError((onError) {
      setState(() {
        signinerror = true;
        signinerrormessage = onError.message;
        signinloading = false;
      });
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userregistered');
    widget.setUser();
  }

  void requestuserdetails() async {
    var token = await FirebaseAuth.instance.currentUser.getIdToken(true);
    var value = FirebaseAuth.instance.currentUser;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response =
          await RestAPI().getTheRequest('getuserdetails/${value.uid}', token);

      if (response.statusCode == 200) {
        var checkusername = jsonDecode(response.body);
        if (checkusername['message'] == "NO_USERNAME_FOUND") {
          prefs.setString('userregistered', "no");
          //storage.write(key: "userregistered", value: "no");
        } else {
          prefs.setString('userregistered', "yes");
          //storage.write(key: "userregistered", value: "yes");
        }
        setState(() {
          signinloading = false;
          createloading = false;
        });
        widget.setUser();
      }
    } catch (e) {
      signOut();
    }
  }

  void signup() {
    if (_emailcreate.text.isEmpty) {
      setState(() {
        emailcreateerror = true;
      });
      return;
    }
    if (_passwordcreate.text.isEmpty) {
      setState(() {
        passwordcreateerror = true;
      });
      return;
    }
    setState(() {
      emailcreateerror = false;
      passwordcreateerror = false;
      createloading = true;
    });
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailcreate.text, password: _passwordcreate.text)
        .then((value) async {
      setState(() {
        createerror = false;
        createerrormessage = "";
      });
      requestuserdetails();
    }).catchError((onError) {
      //if (onError.code == "invalid-email") {
      setState(() {
        createerror = true;
        createerrormessage = onError.message;
        createloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.chooseloginorcreate
        ? Column(
            children: [
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email (required)',
                  errorText: emailloginerror ? "Email cannot be empty" : null,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _password,
                obscureText: !showpasswordforlogin,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password (required)',
                  errorText:
                      passwordloginerror ? "Password cannot be empty" : null,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showpasswordforlogin = !showpasswordforlogin;
                      });
                    },
                    icon: showpasswordforlogin
                        ? Icon(CupertinoIcons.eye)
                        : Icon(CupertinoIcons.eye_slash),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              signinerror
                  ? Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Center(
                        child: Text(
                          '$signinerrormessage',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      color: Colors.red[400],
                      width: MediaQuery.of(context).size.width,
                      height: 70.0,
                    )
                  : Container(),
              SizedBox(
                height: 30.0,
              ),
              signinloading
                  ? CircularProgressIndicator()
                  : TextButton(
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        signin();
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 60),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    ),
            ],
          )
        : Column(
            children: [
              TextField(
                controller: _emailcreate,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email (required)',
                  errorText: emailcreateerror ? "Email cannot be empty" : null,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _passwordcreate,
                obscureText: !showpasswordforcreate,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password (required)',
                  errorText:
                      passwordcreateerror ? "Password cannot be empty" : null,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showpasswordforcreate = !showpasswordforcreate;
                      });
                    },
                    icon: showpasswordforcreate
                        ? Icon(CupertinoIcons.eye)
                        : Icon(CupertinoIcons.eye_slash),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              createerror
                  ? Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Center(
                        child: Text(
                          '$createerrormessage',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      color: Colors.red[400],
                      width: MediaQuery.of(context).size.width,
                      height: 70.0,
                    )
                  : Container(),
              SizedBox(
                height: 30.0,
              ),
              createloading
                  ? CircularProgressIndicator()
                  : TextButton(
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        signup();
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 60),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    )
            ],
          );
  }
}
