import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/components/googlemap.dart';
import 'package:travelpointer/components/pageviewlocationinfo.dart';
import 'package:travelpointer/models/alldata.dart';

class MapWithMarkers extends StatefulWidget {
  final int index;
  // final double lat;
  // final double lng;
  // final String city;
  // final BitmapDescriptor myIcon;
  const MapWithMarkers({Key key, this.index}) : super(key: key);
  @override
  _MapWithMarkersState createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Map allFunctionandMethods = {};
  // Widget buildBottomSheet(BuildContext context) {
  //   return Container(
  //     height: 200.0,
  //     child: Text('Hello Bottom Sheet'),
  //   );
  // }
  BitmapDescriptor myIcon;

  void moveTheCamera() async {
    // final GoogleMapController controller = await _controller.future;
    // var selectedMarker =
    //     Provider.of<AllData>(context, listen: false).getMarkers[widget.index];
    // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //   target: LatLng(selectedMarker['location']['coordinates'][0],
    //       selectedMarker['location']['coordinates'][1]),
    //   zoom: 17.00,
    // )));
    print("${widget.index} this is the index");
  }

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
    moveTheCamera();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(22.5937, 78.9629);
    final CameraPosition _kGooglePlex = CameraPosition(
      target: _center,
      zoom: 5,
    );

    PageController _pageviewcontroller = PageController(
      initialPage: 0,
    );

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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapWithMarkers(
                index: i,
              ),
            ),
          ),
        ),
      );
      i++;
    }
    //print(tempMarkers.length);
    setState(() {
      _markers = {...tempMarkers};
    });
    //allFunctionandMethods = {"_kGooglePlex": _kGooglePlex, "markers": _markers};
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('All Your Markers'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
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
          Expanded(
            flex: 2,
            child: PageView(
              controller: _pageviewcontroller,
              children: [
                PageViewLocationInfo(),
                PageViewLocationInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
