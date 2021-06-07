import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/components/addlocationlistview.dart';
import 'package:http/http.dart' as http;
import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/models/firebasedata.dart';
import 'package:travelpointer/screens/addnewlocation.dart';
import 'dart:convert';
import 'package:travelpointer/classes/restapi.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddTrip extends StatefulWidget {
  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  TextEditingController _captiontexfieldController;
  var locations = [];
  var errorcheck = false;
  var loading = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    _captiontexfieldController = TextEditingController();
  }

  void addlocations(Map location) {
    setState(() {
      locations = [...locations, location];
    });
    print(locations);
  }

  void deleteonelocation(int index) {
    var alllocations = [...locations];
    alllocations.removeAt(index);
    setState(() {
      locations = [...alllocations];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add a new trip',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          locations.length == 0
              ? Text("")
              : Padding(
                  padding: const EdgeInsets.only(top: 13.0, right: 13.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (_captiontexfieldController.text.isEmpty) {
                        setState(() {
                          errorcheck = true;
                        });
                        return;
                      }
                      setState(() {
                        errorcheck = false;
                        loading = true;
                      });
                      var body = jsonEncode({
                        'caption': _captiontexfieldController.text,
                        'locations': locations
                      });

                      var token =
                          Provider.of<FirebaseData>(context, listen: false)
                              .token;
                      var uid = FirebaseAuth.instance.currentUser.uid;
                      http.Response response = await RestAPI()
                          .postTheRequest('user/$uid/location', body, token);
                      if (response.statusCode == 200) {
                        var userlocation = jsonDecode(response.body);
                        print(userlocation['result']);
                        Provider.of<AllData>(context, listen: false)
                            .setanotherMarker(userlocation['result']);

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
        ],
      ),
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextField(
                        cursorHeight: 40.0,
                        style: TextStyle(fontSize: 23.0),
                        controller: _captiontexfieldController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          border: UnderlineInputBorder(),
                          errorText:
                              errorcheck ? "Please provide the caption" : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: AddLocationListView(
                          locations: locations,
                          deleteonelocation: deleteonelocation,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AddaNewLocation(addlocation: addlocations),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black, width: 1.0)),
                        ),
                        child: Text(
                          'Add location',
                          textAlign: TextAlign.center,
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
