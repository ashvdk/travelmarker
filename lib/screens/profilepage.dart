import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelpointer/classes/user.dart';
import 'package:travelpointer/components/ProfileWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'package:travelpointer/screens/addnewlocation.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future getProfileInfo() async {
    var token = await FirebaseAuth.instance.currentUser.getIdToken(true);
    var uid = FirebaseAuth.instance.currentUser.uid;
    http.Response response = await http.get(
        'http://192.168.43.145:6000/user/$uid',
        headers: {HttpHeaders.authorizationHeader: token});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AddaNewLocation(),
              ));
        },
        child: Icon(Icons.add_location_alt_outlined),
      ),
      body: FutureBuilder(
        future: getProfileInfo(),
        builder: (context, profileSnap) {
          if (profileSnap.hasData) {
            if (profileSnap.data.statusCode == 200) {
              return ProfileWidget(
                user: ProfileUser(
                    uid: jsonDecode(profileSnap.data.body)['_id'],
                    email: jsonDecode(profileSnap.data.body)['email'],
                    displayName:
                        jsonDecode(profileSnap.data.body)['displayName']),
              );
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
