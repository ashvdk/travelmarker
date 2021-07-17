import 'package:flutter/material.dart';

import 'package:travelpointer/components/addlocationlistview.dart';

import 'package:travelpointer/screens/addnewlocation.dart';

import 'package:travelpointer/screens/viewyourlocations.dart';

class AddTrip extends StatefulWidget {
  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  TextEditingController _captiontexfieldController;
  var locations = [];
  var errorcheck = false;
  var loading = false;
  var optimalZoom = null;
  var optimalCoordinates = null;
  var alllocations = [];
  var numberofimages = 0;

  void setSettings(double zoom, List coordinates) {
    setState(() {
      optimalZoom = zoom;
      optimalCoordinates = coordinates;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _captiontexfieldController = TextEditingController();
  }

  void addlocations(Map location) {
    setState(() {
      locations = [...locations, location];
      alllocations = [
        ...alllocations,
        {...location, 'downloadurls': [], 'filepath': []}
      ];
      numberofimages = numberofimages + location['filepath'].length;
    });
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
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ViewYourLocations(
                              location: {
                                'caption': _captiontexfieldController.text,
                                'locations': locations,
                                'optimalCoordinates': [22.5937, 78.9629],
                                'optimalZoom': 5
                              },
                              newlocations: alllocations,
                              numberofimages: numberofimages),
                        ),
                      );
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
        ],
      ),
      body: SafeArea(
        child: Container(
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
                    errorText: errorcheck ? "Please provide the caption" : null,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
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
