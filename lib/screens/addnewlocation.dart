import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/addanewlocation.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:travelpointer/components/categorieswithicons.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:geocoder/geocoder.dart';
import 'dart:convert';

import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/screens/selectcategory.dart';

class AddaNewLocation extends StatefulWidget {
  @override
  _AddaNewLocationState createState() => _AddaNewLocationState();
}

class _AddaNewLocationState extends State<AddaNewLocation> {
  Completer<GoogleMapController> _controller = Completer();
  AddANewLocation newlocationdata = AddANewLocation();
  var stepperForm = "collect_map_coordinates";

  @override
  void initState() {
    super.initState();
    print("called init ");
    _goToTheLake();
  }

  Set<Marker> _markers = {};
  static const LatLng _center = const LatLng(22.5937, 78.9629);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: _center,
    zoom: 5,
  );
  static final CameraPosition _kLake = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 15.00,
  );
  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  var category;
  void setCategory(String categoryType) {
    setState(() {
      category = categoryType;
    });
  }

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
    Widget selectedElements() {
      if (stepperForm == "collect_map_coordinates") {
        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: _onCameraMove,
                    markers: _markers,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/locationmarker.png',
                      width: 40.0,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    color: Colors.lightBlueAccent,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    height: 50.0,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    height: 50.0,
                    onPressed: () async {
                      Provider.of<AddANewLocation>(context, listen: false)
                          .setSaveCurrentLocation([
                        _lastMapPosition.latitude,
                        _lastMapPosition.longitude,
                      ]);
                      setState(() {
                        stepperForm = "select_category";
                      });

                      //Navigator.of(context).pushNamed('selectlocationcategory');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         SelectLocationCategory(),
                      //   ),
                      // );
                      // final coordinates = new Coordinates(
                      //     newlocationdata.currentLocationData[1],
                      //     newlocationdata.currentLocationData[0]);
                      // var address = await Geocoder.local
                      //     .findAddressesFromCoordinates(coordinates);
                      // newlocationdata.city = address.first.locality;
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      } else if (stepperForm == "select_category") {
        return Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  CategoriesWithIcons(
                    geticons: Icons.agriculture,
                    title: 'Agriculture',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.ev_station_rounded,
                    title: 'EV Station',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.electric_scooter,
                    title: 'Electric Scooter',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.local_grocery_store_outlined,
                    title: 'Shopping',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.bike_scooter,
                    title: 'Rent Bikes',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.waves,
                    title: 'Beach',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.terrain,
                    title: 'Terrain',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.agriculture,
                    title: 'Agriculture',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.agriculture,
                    title: 'Agriculture',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.agriculture,
                    title: 'Agriculture',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                  CategoriesWithIcons(
                    geticons: Icons.agriculture,
                    title: 'Agriculture',
                    setCategoryFunc: setCategory,
                    category: category,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    color: Colors.lightBlueAccent,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    height: 50.0,
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    splashColor: Colors.blueAccent,
                    height: 50.0,
                    onPressed: () {
                      Provider.of<AddANewLocation>(context, listen: false)
                          .setCategory(category);
                      setState(() {
                        stepperForm = "add_description";
                      });
                      // Navigator.of(context)
                      //     .pushNamed('adddescriptionaboutthelocation');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         AddDescriptionAboutTheLocation(),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      } else if (stepperForm == "add_description") {
        return Container(
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
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add a new location'),
      ),
      body: selectedElements(),
      floatingActionButton: stepperForm == "collect_map_coordinates"
          ? FloatingActionButton(
              onPressed: () => _goToTheLake(),
              child: Icon(Icons.my_location),
            )
          : null,
    );
  }

  Future<void> _goToTheLake() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    // newlocationdata.currentLocationData = [
    //   _locationData.longitude,
    //   _locationData.latitude
    // ];
    // print(_locationData.longitude);
    // print(_locationData.latitude);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(_locationData.latitude, _locationData.longitude),
      zoom: 17.00,
    )));
  }
}
