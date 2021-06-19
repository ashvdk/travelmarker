import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninWithUsernameandPassword extends StatefulWidget {
  final bool chooseloginorcreate;
  SigninWithUsernameandPassword({this.chooseloginorcreate});
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

  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _emailcreate = TextEditingController();
    _passwordcreate = TextEditingController();
  }

  void signin() {
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
    });
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _email.text, password: _password.text)
        .then((value) => print(value))
        .catchError((onError) {
      setState(() {
        signinerror = true;
        signinerrormessage = "Email and Password is incorrect";
      });
    });
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
    });
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailcreate.text, password: _passwordcreate.text)
        .then((value) {
      print("in then");
      print(value);
    }).catchError((onError) {
      //if (onError.code == "invalid-email") {
      setState(() {
        signinerror = true;
        signinerrormessage = onError.message;
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
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password (required)',
                    errorText:
                        passwordloginerror ? "Password cannot be empty" : null),
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
              TextButton(
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  signin();
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(MediaQuery.of(context).size.width, 60),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password (required)',
                  errorText:
                      passwordcreateerror ? "Password cannot be empty" : null,
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
              TextButton(
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  signup();
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(MediaQuery.of(context).size.width, 60),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  backgroundColor: Colors.pink[600],
                ),
              )
            ],
          );
  }
}
