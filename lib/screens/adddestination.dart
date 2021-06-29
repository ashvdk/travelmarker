import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelpointer/components/adddestinationdetails.dart';
import 'package:travelpointer/components/destinationlist.dart';

class AddDestination extends StatefulWidget {
  @override
  _AddDestinationState createState() => _AddDestinationState();
}

class _AddDestinationState extends State<AddDestination> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  var addedlocation = false;
  var destinations = [];
  var markerid = 0;
  LatLng _lastMapPosition = LatLng(22.5937, 78.9629);

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void addDestination(Map destination) async {
    var tempMARKERS = _markers.toList();
    tempMARKERS.removeLast();
    tempMARKERS.toSet();
    tempMARKERS.add(Marker(
      markerId: MarkerId("$markerid"),
      position:
          LatLng(destination['coordinates'][0], destination['coordinates'][1]),
      infoWindow: InfoWindow(title: destination['name']),
      icon: BitmapDescriptor.defaultMarker,
    ));
    setState(() {
      _markers = {...tempMARKERS};
      destinations = [...destinations, destination];
      markerid += 1;
    });
  }

  void showmarkerinfowindow() async {
    GoogleMapController controller = await _controller.future;

    var trueorrfalse =
        controller.isMarkerInfoWindowShown(MarkerId("${markerid - 1}"));
    trueorrfalse.then((value) {
      value
          ? print("showing")
          : controller.showMarkerInfoWindow(MarkerId("${markerid - 1}"));
    });
  }

  void getPermissionToAddMarker() {
    setState(() {
      addedlocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(22.5937, 78.9629);
    final CameraPosition _kGooglePlex = CameraPosition(
      target: _center,
      zoom: 5,
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              onCameraMove: _onCameraMove,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
            ),
          ),
          Positioned(
            bottom: 0.0,
            height: 400.0,
            child: Container(
              padding: EdgeInsets.only(top: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: Colors.white,
              ),
              child: addedlocation
                  ? AddDestinationDetails(
                      getPermissionToAddMarker: getPermissionToAddMarker,
                      addDestination: addDestination,
                      lastMapPosition: _lastMapPosition,
                      showmarkerinfowindow: showmarkerinfowindow,
                    )
                  : DestinationList(destinations: destinations),
            ),
          ),
          addedlocation
              ? Container()
              : Positioned(
                  top: MediaQuery.of(context).size.height - 460,
                  right: 10.0,
                  child: GestureDetector(
                    onTap: () async {
                      if (!addedlocation) {
                        Set<Marker> tempmarkers = {};
                        tempmarkers.add(Marker(
                          markerId: MarkerId("$markerid"),
                          position: _lastMapPosition,
                          icon: BitmapDescriptor.defaultMarker,
                        ));
                        setState(() {
                          _markers = {..._markers, ...tempmarkers};
                          addedlocation = true;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                        right: 10.0,
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        color: Colors.pink,
                      ),
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
          addedlocation
              ? Container()
              : Center(
                  child: Image.asset(
                    'assets/locationmarker.png',
                    width: 40.0,
                  ),
                )
        ],
      ),
    );
  }
}
