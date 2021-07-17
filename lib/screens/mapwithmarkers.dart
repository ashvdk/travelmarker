import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/components/pageviewlocationinfo.dart';
import 'package:travelpointer/models/markerimage.dart';

class MapWithMarkers extends StatefulWidget {
  // final LatLng latlng;
  // final String id;
  final List alllocations;
  final Function setSettings;
  const MapWithMarkers({Key key, this.alllocations, this.setSettings})
      : super(key: key);
  @override
  _MapWithMarkersState createState() => _MapWithMarkersState();
}

class _MapWithMarkersState extends State<MapWithMarkers> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  List<Widget> pageviewlocationinfo = [];
  Map allFunctionandMethods = {};
  int pageNumber = 0;
  BitmapDescriptor myIcon;
  PageController _pageviewcontroller;
  double containerHeight = 200.0;

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
    print(widget.alllocations);
    //moveTheCamera(widget.latlng);
  }

  void incdecheightocontainer(double containerheight) {
    setState(() {
      containerHeight = containerheight;
    });
  }

  void _onCameraMove(CameraPosition position) {
    if (widget.setSettings != null) {
      widget.setSettings(
          position.zoom, [position.target.latitude, position.target.longitude]);
    }

    // _lastMapPosition = position.target;
    // _lastMapPosition.latitude,
    // _lastMapPosition.longitude,
    // setState(() {
    //   zoom = position.zoom;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final LatLng _center = LatLng(
        widget.alllocations[0]['optimalCoordinates'][0],
        widget.alllocations[0]['optimalCoordinates'][1]);
    final CameraPosition _kGooglePlex = CameraPosition(
      target: _center,
      zoom: widget.alllocations[0]['optimalZoom'].toDouble(),
    );

    Set<Marker> tempMarkers = {};
    var i = 0;
    List<Widget> pageviewlocationinfoTemp = [];
    for (var marker in widget.alllocations) {
      int setPageNo = i;
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
              .getMarkers(marker['category']),
          onTap: () {
            print(setPageNo);
            // _pageviewcontroller.animateToPage(
            //   setPageNo,
            //   duration: Duration(milliseconds: 250),
            //   curve: Curves.bounceInOut,
            // );
          },
        ),
      );
      pageviewlocationinfoTemp.add(
        PageViewLocationInfo(
          marker: marker,
          incdecheightocontainer: incdecheightocontainer,
        ),
      );

      i++;
    }

    // print(pageviewlocationinfoTemp.length); from here
    setState(() {
      _markers = {...tempMarkers};
      pageviewlocationinfo = [...pageviewlocationinfoTemp];
    });
    _pageviewcontroller = PageController(
      initialPage: pageNumber,
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMove: _onCameraMove,
              markers: _markers,
            ),
          ),
          Positioned(
            bottom: 0.0,
            height: containerHeight,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                onPageChanged: (changedPageNo) async {
                  print(changedPageNo);
                  final GoogleMapController controller =
                      await _controller.future;
                  controller.showMarkerInfoWindow(MarkerId("$changedPageNo"));
                  // var latAndLng = Provider.of<AllData>(context, listen: false)
                  //     .getMarkers[changedPageNo];
                  // moveTheCamera(LatLng(
                  //   double.parse(latAndLng['location']['coordinates'][0]),
                  //   double.parse(latAndLng['location']['coordinates'][1]),
                  // ));
                },
                controller: _pageviewcontroller,
                itemCount: pageviewlocationinfo.length,
                itemBuilder: (BuildContext context, int index) {
                  return pageviewlocationinfo[index];
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
