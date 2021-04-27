import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/user.dart';
import 'package:travelpointer/components/ProfileWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelpointer/models/alldata.dart';
import 'dart:convert';

import 'package:travelpointer/screens/addnewlocation.dart';
import 'package:travelpointer/classes/restapi.dart';

class GetProfileInfo extends StatefulWidget {
  @override
  _GetProfileInfoState createState() => _GetProfileInfoState();
}

class _GetProfileInfoState extends State<GetProfileInfo> {
  Future getProfileInfo() async {
    var token = await FirebaseAuth.instance.currentUser.getIdToken(true);
    var uid = FirebaseAuth.instance.currentUser.uid;
    http.Response response = await RestAPI().getTheRequest('user/$uid', token);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => AddaNewLocation(),
          //   ),
          // );
          Navigator.pushNamed(context, 'addanewlocation');
          Navigator.of(context).pushNamed('addanewlocation');
        },
        child: Icon(Icons.add_location_alt_outlined),
      ),
      body: FutureBuilder(
        future: getProfileInfo(),
        builder: (context, profileSnap) {
          if (profileSnap.hasData) {
            if (profileSnap.data.statusCode == 200) {
              var user = jsonDecode(profileSnap.data.body);
              Provider.of<AllData>(context, listen: false)
                  .setMarkers(user['locationdetails']);
              return ProfileWidget(
                user: ProfileUser(
                  uid: user['_id'],
                  email: user['email'],
                  displayName: user['displayName'],
                ),
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
