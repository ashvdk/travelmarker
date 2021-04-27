import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/addanewlocation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'dart:io';

import 'package:travelpointer/models/alldata.dart';

class AddDescriptionAboutTheLocation extends StatefulWidget {
  @override
  _AddDescriptionAboutTheLocationState createState() =>
      _AddDescriptionAboutTheLocationState();
}

class _AddDescriptionAboutTheLocationState
    extends State<AddDescriptionAboutTheLocation> {
  String title = "";
  String description = "";
  void saveTheNewLocation() async {
    Provider.of<AddANewLocation>(context, listen: false)
        .setTitleDescription(title, description);

    var token = await FirebaseAuth.instance.currentUser.getIdToken(true);
    var uid = FirebaseAuth.instance.currentUser.uid;
    var body =
        Provider.of<AddANewLocation>(context, listen: false).newLocationInfo;
    http.Response response =
        await RestAPI().postTheRequest('user/$uid/location', body, token);
    if (response.statusCode == 200) {
      var userlocation = jsonDecode(response.body);
      Provider.of<AllData>(context, listen: false)
          .setMarkers(userlocation['result']);
      Navigator.of(context).pushNamedAndRemoveUntil(
        'showthelocations',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: Text(
                'Description about the place',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            TextField(
              onChanged: (String value) {
                title = value;
                // newlocationdata.title = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            TextField(
              maxLines: 5,
              onChanged: (String value) {
                description = value;
                // newlocationdata.description = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              splashColor: Colors.blueAccent,
              height: 50.0,
              onPressed: () {
                saveTheNewLocation();
              },
              child: Text(
                'Next',
                style: TextStyle(fontSize: 13.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
