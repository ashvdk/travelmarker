import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelpointer/models/firebasedata.dart';
import 'package:travelpointer/models/recommendedlocations.dart';
import 'package:travelpointer/models/userdetails.dart';
import 'package:travelpointer/components/locationlistview.dart';
import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:http/http.dart' as http;

class FeedScreen extends StatefulWidget {
  final Function setUser;

  const FeedScreen({Key key, this.setUser}) : super(key: key);
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var recommendedLocations = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    getrecommendeddestination();
  }

  void getrecommendeddestination() async {
    var token = await FirebaseAuth.instance.currentUser.getIdToken(true);
    var uid = FirebaseAuth.instance.currentUser.uid;

    http.Response response =
        await RestAPI().getTheRequest('getrecommendeddestinations/$uid', token);
    if (response.statusCode == 200) {
      var recommendedlocations = jsonDecode(response.body)['result'];

      Provider.of<Recommendedlocations>(context, listen: false)
          .setRecommendedLocations(recommendedlocations);

      getallrecommendedlocations();
    }
  }

  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userregistered');
    widget.setUser();
  }

  void getallrecommendedlocations() {
    var tempRecommendedlocations = [
      ...Provider.of<Recommendedlocations>(context, listen: false).getLocations
    ];

    var temporaryrecommdlocations = tempRecommendedlocations.map((e) {
      return LocationListView(
        user: e['user'][0],
        location: e['recommended_locations'],
        liteModeEnabled: true,
      );
    });

    setState(() {
      recommendedLocations = [...temporaryrecommdlocations];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xfff4f4f4),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  bottom: 15.0,
                  top: 15.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Services',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.luggage,
                                  size: 40.0,
                                  color: Colors.blue,
                                ),
                                Text('luggages')
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: signOutGoogle,
                    child: Text('Logout'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var token =
                          Provider.of<FirebaseData>(context, listen: false)
                              .token;
                      var uid = FirebaseAuth.instance.currentUser.uid;
                      http.Response response = await RestAPI().getTheRequest(
                          'getrecommendeddestinations/$uid', token);
                      if (response.statusCode == 200) {
                        var recommendedlocations =
                            jsonDecode(response.body)['result'];

                        Provider.of<Recommendedlocations>(context,
                                listen: false)
                            .setRecommendedLocations(recommendedlocations);
                        getallrecommendedlocations();
                      }
                    },
                    child: Text('Get destinations'),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    children: [
                      Text(
                        'Recommended Destinations For You',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      ...recommendedLocations
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
