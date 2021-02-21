import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Completer<GoogleMapController> _controller = Completer();

class MapWithMarkers extends StatefulWidget {
  final double lat;
  final double lng;
  final String city;
  const MapWithMarkers({Key key, this.lat, this.lng, this.city})
      : super(key: key);
  @override
  _MapWithMarkersState createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  Set<Marker> _markers = {};
  Widget buildBottomSheet(BuildContext context) {
    return Container(
      height: 200.0,
      child: Text('Hello Bottom Sheet'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(widget.lat, widget.lng);
    final CameraPosition _kGooglePlex = CameraPosition(
      target: _center,
      zoom: 12,
    );
    if (widget.city == "Mysore") {
      _markers = {
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("kgvgv6556nvvuh"),
          position: LatLng(12.3052, 76.6550),
          infoWindow: InfoWindow(
            title: 'Mysore Palace',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("kgvgv6556nvvuh"),
          position: LatLng(12.3100, 76.6450),
          infoWindow: InfoWindow(
            title: 'Mysore Palace',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("kgv546556nvvuh"),
          position: LatLng(12.3200, 76.6750),
          infoWindow: InfoWindow(
            title: 'Chamundi Beta',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId("kg35fgbvuhdb"),
          position: LatLng(12.3300, 76.6850),
          infoWindow: InfoWindow(
            title: 'Mysore zoo',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      };
    } else if (widget.city == "Chikmagalur") {
      _markers = {
        Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId("fh45dtnd6nvvuh"),
            position: LatLng(13.3229, 75.4330),
            infoWindow: InfoWindow(
              title: 'Hebbe Falls',
              snippet: '5 Star Rating',
            ),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {
              showModalBottomSheet(context: context, builder: buildBottomSheet);
            })
      };
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('All Your Markers'),
      ),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: _markers,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Add Marker'),
        icon: Icon(Icons.add_location_alt_outlined),
      ),
    );
  }
}
