import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelpointer/components/clublistcomponent.dart';
import 'package:travelpointer/screens/addnewclubscreen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:travelpointer/models/firebasedata.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClubScreen extends StatefulWidget {
  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  var clubs = [];
  var loading = true;
  void getClubsFromTheUser() async {
    var token = Provider.of<FirebaseData>(context, listen: false).token;
    var uid = FirebaseAuth.instance.currentUser.uid;
    http.Response response =
        await RestAPI().getTheRequest('user/${uid}/getallclubs', token);
    if (response.statusCode == 200) {
      var userclubs = jsonDecode(response.body);
      setState(() {
        clubs = userclubs['result'];
        loading = false;
      });
    }
  }

  void addClubs(Map club) {
    setState(() {
      clubs = [...clubs, club];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClubsFromTheUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading
            ? Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Your clubs",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddNewClubScreen(
                                addClubs: addClubs,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 2, bottom: 2),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.pink[50],
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.pink,
                                size: 20,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Add New",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: ClubListComponent(
                      clubs: clubs,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
