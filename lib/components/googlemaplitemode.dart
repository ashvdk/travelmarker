import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/models/markerimage.dart';

class GoogleMapLiteMode extends StatefulWidget {
  final List location;
  final double optimalZoom;
  final List optimalCoordinates;
  GoogleMapLiteMode({this.location, this.optimalZoom, this.optimalCoordinates});
  @override
  _GoogleMapLiteModeState createState() => _GoogleMapLiteModeState();
}

class _GoogleMapLiteModeState extends State<GoogleMapLiteMode> {
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  var lat;
  var lng;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_goToTheLocation();
  }

  // Future<void> _goToTheLocation() async {
  //   if (widget.coordinates != null) {
  //     lat = widget.coordinates.split(",")[0];
  //     lng = widget.coordinates.split(",")[1];
  //     _markers.add(
  //       Marker(
  //         // This marker id can be anything that uniquely identifies each marker.
  //         markerId: MarkerId("dbgdfgbdf"),
  //         position: LatLng(
  //           double.parse(lat),
  //           double.parse(lng),
  //         ),
  //       ),
  //     );
  //   } else {}
  // }

  @override
  Widget build(BuildContext context) {
    final LatLng _center =
        LatLng(widget.optimalCoordinates[0], widget.optimalCoordinates[1]);
    final CameraPosition _kGooglePlex = CameraPosition(
      target: _center,
      zoom: widget.optimalZoom,
    );
    Set<Marker> tempMarkers = {};
    var i = 0;
    for (var marker in widget.location) {
      var coOrdinates = marker['coordinates'].split(", ");
      var lat = coOrdinates[0];
      var lng = coOrdinates[1];

      tempMarkers.add(
        Marker(
            markerId: MarkerId("$i"),
            position: LatLng(
              double.parse(lat),
              double.parse(lng),
            ),
            infoWindow: InfoWindow(title: marker['name']),
            icon: Provider.of<MarkerImage>(context, listen: true)
                .getMarkers(marker['category'])),
      );
      i++;
    }
    setState(() {
      _markers = {...tempMarkers};
    });
    return GoogleMap(
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
    );
  }
}
