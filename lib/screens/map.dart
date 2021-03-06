import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/components/googlemap.dart';
import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/models/markerimage.dart';
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
    });
  }

  static const LatLng _center = const LatLng(22.5937, 78.9629);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: _center,
    zoom: 5,
  );

  @override
  Widget build(BuildContext context) {
    var allMarkers = Provider.of<AllData>(context, listen: true).getMarkers;
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
          icon: Provider.of<MarkerImage>(context, listen: true)
              .getMarkers(marker['category']),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MapWithMarkers(
            //       latlng: LatLng(
            //         double.parse(marker['location']['coordinates'][0]),
            //         double.parse(marker['location']['coordinates'][1]),
            //       ),
            //       id: marker["_id"],
            //     ),
            //   ),
            // );
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
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: _kGooglePlex,
          liteModeEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            Completer<GoogleMapController> _controller = Completer();
            // controller.setMapStyle(_mapStyle);
            _controller.complete(controller);
          },
          markers: _markers,
        ),
      ),
    );
  }
}
