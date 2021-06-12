import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/user.dart';
import 'package:travelpointer/components/ProfileWidget.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/models/userdetails.dart';
import 'package:travelpointer/screens/clubscreen.dart';
import 'package:travelpointer/screens/addlocation.dart';
import 'dart:convert';
import 'package:travelpointer/classes/restapi.dart';
import 'package:travelpointer/screens/addtrip.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  ProfilePage({this.uid});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future getProfileInfo() async {
    var token = await FirebaseAuth.instance.currentUser.getIdToken(true);
    http.Response response =
        await RestAPI().getTheRequest('user/${widget.uid}', token);
    var userDetails = jsonDecode(response.body)['result'];
    Provider.of<UserDetails>(context, listen: false)
        .setUserDetails(userDetails['user']);
    Provider.of<AllData>(context, listen: false)
        .setMarkers(userDetails['locations']);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF9971ee),
      floatingActionButton: widget.uid == FirebaseAuth.instance.currentUser.uid
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Choose option',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => AddTrip(),
                                ),
                              );
                            },
                            child: Text(
                              'Add Trip',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              //minimumSize: Size(500, 60),
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'Club',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ClubScreen(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              //minimumSize: Size(500, 60),
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );

                //Navigator.pushNamed(context, 'addanewlocation');
                //Navigator.of(context).pushNamed('addanewlocation');
              },
              child: Icon(Icons.add_location_alt_outlined),
            )
          : null,
      body: FutureBuilder(
        future: getProfileInfo(),
        builder: (context, profileSnap) {
          if (profileSnap.hasData) {
            if (profileSnap.data.statusCode == 200) {
              return ProfileWidget();
            } else {
              return Container(
                child: Center(
                  child: Text('Please try after some time'),
                ),
              );
            }
          } else if (profileSnap.hasError) {
            return Container(
              child: Center(
                child: Text('Please try after some time'),
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            );
          }
        },
      ),
    );
  }
}
