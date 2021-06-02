import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:travelpointer/components/searchresultcomponent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:travelpointer/models/firebasedata.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchtextfieldController;
  var usersList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchtextfieldController = TextEditingController();
  }

  Future getTheUsersList(String username) async {
    var token = Provider.of<FirebaseData>(context, listen: false).token;
    var uid = FirebaseAuth.instance.currentUser.uid;
    http.Response response = await RestAPI()
        .getTheRequest('searchusername?username=${username}&uid=${uid}', token);
    var users = jsonDecode(response.body)['result'];
    setState(() {
      usersList = [...users];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(usersList);
    return Scaffold(
      //backgroundColor: Color(0xFF05a859), //60992D,
      backgroundColor: Colors.black, //60992D,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, bottom: 30.0, right: 30.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Search for people',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      // fontWeight: FontWeight.bold,
                    ),
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
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        //borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: Colors.white, width: 2.0),
                        borderSide: BorderSide(color: Colors.white),
                        //borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(CupertinoIcons.search),
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
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(30.0),
                //   topRight: Radius.circular(30.0),
                // ),
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
