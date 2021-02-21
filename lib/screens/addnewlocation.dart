import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travelpointer/components/categorieswithicons.dart';

Completer<GoogleMapController> _controller = Completer();

class AddaNewLocation extends StatefulWidget {
  @override
  _AddaNewLocationState createState() => _AddaNewLocationState();
}

class _AddaNewLocationState extends State<AddaNewLocation> {
  var currentLocationData;
  var stepperForm = "collect_map_coordinates";
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    Widget returnWidget() {
      if (stepperForm == "collect_map_coordinates") {
        return Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _markers,
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
                      setState(() {
                        stepperForm = "select_category";
                      });
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
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
                  CategoriesWithIcons(),
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
                    onPressed: () {},
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
      body: returnWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToTheLake(),
        child: Icon(Icons.my_location),
      ),
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
    setState(() {
      currentLocationData = [_locationData.longitude, _locationData.latitude];
    });
    // print(_locationData.longitude);
    // print(_locationData.latitude);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(_locationData.latitude, _locationData.longitude),
      zoom: 17.00,
    )));
  }
}
