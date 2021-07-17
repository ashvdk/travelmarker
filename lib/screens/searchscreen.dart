import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:travelpointer/components/clublistcomponent.dart';
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
  var results = [];
  var option = "people";
  String searchterm = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchtextfieldController = TextEditingController();
  }

  Future getTheResult() async {
    var token = Provider.of<FirebaseData>(context, listen: false).token;
    var uid = FirebaseAuth.instance.currentUser.uid;

    http.Response response = await RestAPI()
        .getTheRequest('search?q=$searchterm&uid=$uid&option=$option', token);
    var result = jsonDecode(response.body)['result'];
    setState(() {
      results = [...result];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF05a859), //60992D,
      // backgroundColor: Colors.black, //60992D,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, bottom: 30.0, right: 30.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Search',
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
                      setState(() {
                        searchterm = value;
                      });
                      await getTheResult();
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
          Container(
            padding: EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        option = "people";
                      });
                      if (searchterm.length >= 5) {
                        getTheResult();
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "People",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          option == "people"
                              ? Icon(
                                  CupertinoIcons.checkmark,
                                  color: Colors.pink,
                                  size: 20,
                                )
                              : Text(""),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        option = "clubs";
                      });
                      if (searchterm.length >= 5) {
                        getTheResult();
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Clubs",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          option == "clubs"
                              ? Icon(
                                  CupertinoIcons.checkmark,
                                  color: Colors.pink,
                                  size: 20,
                                )
                              : Text(""),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
              child: option == "people"
                  ? SearchResultComponent(users: results)
                  : ClubListComponent(
                      clubs: results,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
