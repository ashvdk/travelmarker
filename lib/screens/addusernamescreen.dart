import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:travelpointer/classes/restapi.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUsernameScreen extends StatefulWidget {
  final Function setUser;
  const AddUsernameScreen({Key key, this.setUser}) : super(key: key);

  @override
  _AddUsernameScreenState createState() => _AddUsernameScreenState();
}

class _AddUsernameScreenState extends State<AddUsernameScreen> {
  //final storage = new FlutterSecureStorage();
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
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose your username',
                    style: TextStyle(fontSize: 35.0),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  cursorHeight: 40.0,
                  style: TextStyle(fontSize: 23.0),
                  controller: _usernametexfieldController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    border: UnderlineInputBorder(),
                    errorText: _validateUsername == "NO_USERNAME"
                        ? "Please enter your username"
                        : _validateUsername == "USERNAME_SHORT"
                            ? "Username should more the 5 letters"
                            : _validateUsername == "USERNAME_EXISTS"
                                ? "Username already exisits"
                                : null,
                  ),
                ),
                SizedBox(
                  height: 30.0,
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
                    var token = await FirebaseAuth.instance.currentUser
                        .getIdToken(true);
                    var value = FirebaseAuth.instance.currentUser;
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var body = jsonEncode({
                      "uid": value.uid,
                      "email": value.email,
                      "displayName": value.displayName,
                      "username": _usernametexfieldController.text,
                      "photoURL": value.photoURL
                    });

                    http.Response response =
                        await RestAPI().postTheRequest('user', body, token);

                    if (response.statusCode == 200) {
                      prefs.setString('userregistered', "yes");
                      //storage.write(key: "userregistered", value: "yes");
                      widget.setUser();
                    } else {
                      //print("wrong username");
                      setState(() {
                        _validateUsername = "USERNAME_EXISTS";
                        showLoading = false;
                      });
                    }
                  },
                  child: showLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Text('Save'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: Size(MediaQuery.of(context).size.width, 60),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    backgroundColor: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
