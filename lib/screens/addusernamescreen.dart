import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:travelpointer/classes/restapi.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddUsernameScreen extends StatefulWidget {
  final Function setUser;
  const AddUsernameScreen({Key key, this.setUser}) : super(key: key);

  @override
  _AddUsernameScreenState createState() => _AddUsernameScreenState();
}

class _AddUsernameScreenState extends State<AddUsernameScreen> {
  final storage = new FlutterSecureStorage();
  TextEditingController _usernametexfieldController;
  bool showLoading = false;
  String _validateUsername;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernametexfieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Add Username',
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(
                height: 50.0,
              ),
              TextField(
                controller: _usernametexfieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  errorText: _validateUsername == "NO_USERNAME"
                      ? "Please enter your username"
                      : _validateUsername == "USERNAME_SHORT"
                          ? "Username should more the 5 letters"
                          : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () async {
                  if (_usernametexfieldController.text.isEmpty) {
                    setState(() {
                      _validateUsername = "NO_USERNAME";
                    });
                    return;
                  } else {
                    if (_usernametexfieldController.text.length < 5) {
                      setState(() {
                        _validateUsername = "USERNAME_SHORT";
                      });
                      return;
                    } else {
                      setState(() {
                        _validateUsername = "USERNAME_OK";
                        showLoading = true;
                      });
                    }
                  }
                  var token =
                      await FirebaseAuth.instance.currentUser.getIdToken(true);
                  var value = FirebaseAuth.instance.currentUser;
                  var body = {
                    "uid": value.uid,
                    "email": value.email,
                    "displayName": value.displayName,
                    "username": _usernametexfieldController.text
                  };

                  http.Response response =
                      await RestAPI().postTheRequest('user', body, token);
                  if (response.statusCode == 200) {
                    storage.write(key: "userregistered", value: "yes");
                    widget.setUser();
                  }
                },
                child: showLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Text('Save'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(500, 60),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  backgroundColor: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
