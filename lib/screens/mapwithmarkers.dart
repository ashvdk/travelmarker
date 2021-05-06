import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/components/googlemap.dart';
import 'package:travelpointer/components/pageviewlocationinfo.dart';
import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/models/markerimage.dart';

class MapWithMarkers extends StatefulWidget {
  final LatLng latlng;
  final String id;
  // final double lat;
  // final double lng;
  // final String city;
  // final BitmapDescriptor myIcon;
  const MapWithMarkers({Key key, this.latlng, this.id}) : super(key: key);
  @override
  _MapWithMarkersState createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  List<Widget> pageviewlocationinfo = [];
  Map allFunctionandMethods = {};
  int pageNumber = 0;
  // Widget buildBottomSheet(BuildContext context) {
  //   return Container(
  //     height: 200.0,
  //     child: Text('Hello Bottom Sheet'),
  //   );
  // }
  BitmapDescriptor myIcon;
  PageController _pageviewcontroller;

  void moveTheCamera(LatLng latlng) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latlng,
      zoom: 17.00,
    )));
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
    });
    moveTheCamera(widget.latlng);
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(22.5937, 78.9629);
    final CameraPosition _kGooglePlex = CameraPosition(
      target: _center,
      zoom: 5,
    );

    var allMarkers = Provider.of<AllData>(context).getMarkers;
    Set<Marker> tempMarkers = {};
    var i = 0;
    List<Widget> pageviewlocationinfoTemp = [];
    for (var marker in allMarkers) {
      int setPageNo = i;
      //print(marker["_id"]);
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
            print(setPageNo);
            _pageviewcontroller.animateToPage(setPageNo,
                duration: Duration(milliseconds: 250),
                curve: Curves.bounceInOut);
            // setState(() {
            //   pageNumber = setPageNo;
            // });
            //print(setPageNo);
          },
        ),
      );
      pageviewlocationinfoTemp.add(
        PageViewLocationInfo(
          marker: marker,
        ),
      );
      if (marker['_id'] == widget.id) {
        pageNumber = setPageNo;
      }
      i++;
    }

    print(pageviewlocationinfoTemp.length);
    setState(() {
      _markers = {...tempMarkers};
      pageviewlocationinfo = [...pageviewlocationinfoTemp];
    });
    _pageviewcontroller = PageController(
      initialPage: pageNumber,
    );
    //print(tempMarkers.length);

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
              onPageChanged: (changedPageNo) {
                print(changedPageNo);
                var latAndLng = Provider.of<AllData>(context, listen: false)
                    .getMarkers[changedPageNo];
                moveTheCamera(LatLng(
                  double.parse(latAndLng['location']['coordinates'][0]),
                  double.parse(latAndLng['location']['coordinates'][1]),
                ));
              },
              controller: _pageviewcontroller,
              children: pageviewlocationinfo,
            ),
          ),
        ],
      ),
    );
  }
}
