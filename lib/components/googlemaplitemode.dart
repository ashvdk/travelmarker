import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapLiteMode extends StatefulWidget {
  final String coordinates;
  GoogleMapLiteMode({this.coordinates});
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
    _goToTheLocation();
  }

  Future<void> _goToTheLocation() async {
    if (widget.coordinates != null) {
      lat = widget.coordinates.split(",")[0];
      lng = widget.coordinates.split(",")[1];
      _markers.add(
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("dbgdfgbdf"),
          position: LatLng(
            double.parse(lat),
            double.parse(lng),
          ),
        ),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    LatLng _center;
    if (widget.coordinates != null) {
      _center = new LatLng(double.parse(lat), double.parse(lng));
    } else {
      _center = new LatLng(22.5937, 78.9629);
    }
    final CameraPosition _kGooglePlex = CameraPosition(
      target: _center,
      zoom: widget.coordinates != null ? 17.00 : 5.00,
    );
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
