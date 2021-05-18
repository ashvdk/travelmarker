import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:travelpointer/components/searchresultcomponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchtextfieldController;
  var usersList = [];
  var token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchtextfieldController = TextEditingController();
    getToken();
  }

  void getToken() async {
    token = await FirebaseAuth.instance.currentUser.getIdToken(true);
  }

  Future getTheUsersList(String username) async {
    http.Response response =
        await RestAPI().getTheRequest('searchusername/${username}', token);
    var users = jsonDecode(response.body)['result'];
    setState(() {
      usersList = [...users];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(usersList);
    return Scaffold(
      backgroundColor: Color(0xFF05a859), //60992D,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, bottom: 30.0, right: 30.0),
            child: Column(
              children: [
                Text(
                  'Search for people',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: TextField(
                    cursorColor: Color(0xFF05a859),
                    style: TextStyle(backgroundColor: Colors.white),
                    controller: _searchtextfieldController,
                    onChanged: (value) async {
                      await getTheUsersList(value);
                      print(value);
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _searchtextfieldController.clear();
                        },
                        color: Colors.black,
                        icon: Icon(CupertinoIcons.clear),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: SearchResultComponent(
                users: usersList,
              ),
            ),
          )
        ],
      ),
    );
  }
}
