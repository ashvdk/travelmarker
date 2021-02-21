import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelpointer/screens/mapwithmarkers.dart';
import 'package:location/location.dart';

Completer<GoogleMapController> _controller = Completer();

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  String _mapStyle;
  Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
    getLocation();
    rootBundle.loadString('assets/mapsstyle.json').then((string) {
      _mapStyle = string;
    });
  }

  void getLocation() async {
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
    print(_locationData.longitude);
    print(_locationData.latitude);
  }

  static const LatLng _center = const LatLng(22.5937, 78.9629);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: _center,
    zoom: 5,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  LatLng _lastMapPosition = _center;
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
            title: 'Really cool place',
            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _markers = {
      Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("sb873bh43r"),
        position: LatLng(12.2958, 76.6394),
        infoWindow: InfoWindow(
          title: 'Mysore City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MapWithMarkers(),
              ));
          // final GoogleMapController controller = await _controller.future;
          // controller.animateCamera(
          //   CameraUpdate.newCameraPosition(
          //       CameraPosition(target: LatLng(12.2958, 76.6394), zoom: 12)),
          // );
        },
      ),
      Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("ab84fdgnfdh43r"),
        position: LatLng(12.9141, 74.8560),
        infoWindow: InfoWindow(
          title: 'Mangaluru City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("adndfdnguybh43r"),
        position: LatLng(12.9716, 77.5946),
        infoWindow: InfoWindow(
          title: 'Bengaluru City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("adfgndnnnfghn3r"),
        position: LatLng(15.2993, 74.1240),
        infoWindow: InfoWindow(
          title: 'Goa City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("fdgdbfdr"),
        position: LatLng(13.3161, 75.7720),
        infoWindow: InfoWindow(
          title: 'Chikmagalur City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MapWithMarkers(
                    lat: 13.3161, lng: 75.7720, city: "Chikmagalur"),
              ));
          // final GoogleMapController controller = await _controller.future;
          // controller.animateCamera(
          //   CameraUpdate.newCameraPosition(
          //       CameraPosition(target: LatLng(12.2958, 76.6394), zoom: 12)),
          // );
        },
      )
    };
    return Container(
      height: 200.0,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          // controller.setMapStyle(_mapStyle);
          _controller.complete(controller);
        },
        markers: _markers,
        onCameraMove: _onCameraMove,
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
