import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  final allMethodsandProperties;
  GoogleMaps({this.allMethodsandProperties});
  @override
  State<GoogleMaps> createState() => GoogleMapsState();
}

class GoogleMapsState extends State<GoogleMaps> {
  String _mapStyle;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/mapsstyle.json').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.allMethodsandProperties['markers']);
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      initialCameraPosition: widget.allMethodsandProperties['_kGooglePlex'],
      onMapCreated: (GoogleMapController controller) {
        Completer<GoogleMapController> _controller = Completer();
        // controller.setMapStyle(_mapStyle);
        _controller.complete(controller);
      },
      markers: widget.allMethodsandProperties['markers'],
    );
  }
}
