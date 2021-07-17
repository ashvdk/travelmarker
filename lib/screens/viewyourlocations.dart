import 'package:flutter/material.dart';
import 'package:travelpointer/components/locationlistview.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/models/userdetails.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'dart:convert';
import 'package:travelpointer/models/firebasedata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:http/http.dart' as http;
import 'package:travelpointer/models/alldata.dart';

class ViewYourLocations extends StatefulWidget {
  final Map location;
  final List newlocations;
  final int numberofimages;
  ViewYourLocations({this.location, this.newlocations, this.numberofimages});
  @override
  _ViewYourLocationsState createState() => _ViewYourLocationsState();
}

class _ViewYourLocationsState extends State<ViewYourLocations> {
  var optimalZoom = null;
  var optimalCoordinates = null;
  var alllocations;
  var imagesuploadedurls = [];
  var loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alllocations = [...widget.newlocations];
  }

  void setSettings(double zoom, List coordinates) {
    setState(() {
      optimalZoom = zoom;
      optimalCoordinates = coordinates;
    });
  }

  void submitthedata(String url, String name, int index) async {
    for (var i = 0; i < alllocations.length; i++) {
      if (name == alllocations[i]['name']) {
        alllocations[i]['downloadurls'].add(url);
      }
    }
    if (widget.numberofimages == imagesuploadedurls.length) {
      print(alllocations);
      DateTime now = new DateTime.now();
      var body = jsonEncode({
        'caption': widget.location['caption'],
        'locations': alllocations,
        'optimalCoordinates': optimalCoordinates,
        'optimalZoom': optimalZoom,
        'timeatwhichitwasadded': now.millisecondsSinceEpoch
      });
      var token = Provider.of<FirebaseData>(context, listen: false).token;
      var uid = FirebaseAuth.instance.currentUser.uid;
      http.Response response =
          await RestAPI().postTheRequest('user/$uid/location', body, token);
      if (response.statusCode == 200) {
        var userlocation = jsonDecode(response.body);
        print(userlocation['result']);
        Provider.of<AllData>(context, listen: false)
            .setanotherMarker(userlocation['result']);
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
        //Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserDetails>(context).userdetails;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0,
        actions: <Widget>[
          optimalZoom == null && optimalCoordinates == null
              ? Text('')
              : Padding(
                  padding: const EdgeInsets.only(top: 13.0, right: 13.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        loading = true;
                      });
                      Future.forEach(widget.location['locations'],
                          (locationselement) {
                        var i = 0;
                        Future.forEach(locationselement['filepath'], (element) {
                          List path = element.path.split("/");
                          firebase_storage.Reference ref = firebase_storage
                              .FirebaseStorage.instance
                              .ref()
                              .child('/${path[path.length - 1]}');

                          final metadata = firebase_storage.SettableMetadata(
                              contentType: 'image/jpeg',
                              customMetadata: {
                                'picked-file-path': path[path.length - 1]
                              });
                          ref
                              .putFile(io.File(element.path), metadata)
                              .then((value) {
                            ref.getDownloadURL().then((value) {
                              setState(() {
                                imagesuploadedurls = [
                                  ...imagesuploadedurls,
                                  value
                                ];
                              });
                              submitthedata(value, locationselement['name'], i);
                            });
                          });
                        });
                      });
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
        ],
      ),
      body: SafeArea(
        child: loading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      '${imagesuploadedurls.length}/${widget.numberofimages} photos uploaded',
                    )
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'View as',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Drag the map to show the markers',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Color(0xFFff6666),
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    LocationListView(
                      location: [widget.location],
                      user: user,
                      liteModeEnabled: false,
                      setSettings: setSettings,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
