import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:travelpointer/models/firebasedata.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNewClubScreen extends StatefulWidget {
  final Function addClubs;
  AddNewClubScreen({this.addClubs});
  @override
  _AddNewClubScreenState createState() => _AddNewClubScreenState();
}

class _AddNewClubScreenState extends State<AddNewClubScreen> {
  TextEditingController _clubnametexfieldController;
  TextEditingController _clubcategorytexfieldController;
  TextEditingController _clubdescriptiontexfieldController;
  void initState() {
    // TODO: implement initState
    super.initState();
    _clubnametexfieldController = TextEditingController();
    _clubcategorytexfieldController = TextEditingController();
    _clubdescriptiontexfieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create a Club",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: _clubnametexfieldController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Page name (required)',
              ),
            ),
            Text(
              'Use the name of your business, brand or organisation, or a name that explains what the Page is about. ',
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: _clubcategorytexfieldController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Category (required)',
              ),
            ),
            Text(
              'Choose a category that describes what type of business, organisation or topic the Page represents.',
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: _clubdescriptiontexfieldController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description (required)',
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextButton(
              child: Text(
                'Create Club',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                var body = jsonEncode({
                  'clubname': _clubnametexfieldController.text,
                  'clubcategory': _clubcategorytexfieldController.text,
                  'clubdescription': _clubdescriptiontexfieldController.text
                });

                var token =
                    Provider.of<FirebaseData>(context, listen: false).token;
                var uid = FirebaseAuth.instance.currentUser.uid;
                http.Response response = await RestAPI()
                    .postTheRequest('user/$uid/createclub', body, token);
                if (response.statusCode == 200) {
                  widget.addClubs(jsonDecode(response.body)['result']);
                  Navigator.pop(context);
                }
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                minimumSize: Size(MediaQuery.of(context).size.width, 60),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                backgroundColor: Colors.blue,
              ),
            )
          ],
        ),
      )),
    );
  }
}
