import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/components/googlemap.dart';
import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/screens/mapwithmarkers.dart';
import 'package:location/location.dart';

Completer<GoogleMapController> _controller = Completer();

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Map allFunctionandMethods = {};
  Set<Marker> _markers = {};
  BitmapDescriptor myIcon;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/mappin.png')
        .then((onValue) {
      setState(() {
        myIcon = onValue;
      });

      print(myIcon);
    });
    print(myIcon);
  }

  static const LatLng _center = const LatLng(22.5937, 78.9629);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: _center,
    zoom: 5,
  );
  void moveToTheOtherPage(context, i) {
    var ourIndex = i;
    print(ourIndex);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MapWithMarkers(
    //       index: i,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    var allMarkers = Provider.of<AllData>(context).getMarkers;
    Set<Marker> tempMarkers = {};
    var i = 0;

    for (var marker in allMarkers) {
      tempMarkers.add(
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("$i"),
          position: LatLng(
            double.parse(marker['location']['coordinates'][0]),
            double.parse(marker['location']['coordinates'][1]),
          ),
          icon: myIcon,
          onTap: () {
            var ourIndex = i;
            moveToTheOtherPage(context, ourIndex);
          },
        ),
      );
      i++;
    }
    //print(tempMarkers.length);
    setState(() {
      _markers = {...tempMarkers};
    });
    allFunctionandMethods = {"_kGooglePlex": _kGooglePlex, "markers": _markers};
    return Container(
      height: 200.0,
      child: GoogleMaps(
        allMethodsandProperties: allFunctionandMethods,
      ),
    );
  }
}
