import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/models/markerimage.dart';
import 'package:travelpointer/screens/photoshowui.dart';
import 'package:image_picker/image_picker.dart';

class GoogleMapLiteMode extends StatefulWidget {
  final List location;
  final double optimalZoom;
  final List optimalCoordinates;
  final int markerid;
  GoogleMapLiteMode(
      {this.location,
      this.optimalZoom,
      this.optimalCoordinates,
      this.markerid});
  @override
  _GoogleMapLiteModeState createState() => _GoogleMapLiteModeState();
}

class _GoogleMapLiteModeState extends State<GoogleMapLiteMode> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  List<Widget> pageviewlocationinfo = [];
  PageController _pageviewcontroller;
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
    List<Widget> pageviewlocationinfoTemp = [];
    for (var marker in widget.location) {
      var coOrdinates = marker['coordinates'].split(", ");
      var lat = coOrdinates[0];
      var lng = coOrdinates[1];
      // print("Filepath printing");
      // print(marker['files'].path);
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
      pageviewlocationinfoTemp.add(Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${marker['name']}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("${marker['description']}"),
            SizedBox(
              height: 20.0,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => PhotoSHowUI(
                                photourl: 'https://picsum.photos/250?image=9'),
                          ),
                        );
                      },
                      child: Image.file(
                        File(marker['files'].path),
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ));
      i++;
    }
    setState(() {
      _markers = {...tempMarkers};
      pageviewlocationinfo = [...pageviewlocationinfoTemp];
    });
    _pageviewcontroller = PageController(
      initialPage: 0,
    );
    return Container(
      height: 400.0,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  liteModeEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    // controller.setMapStyle(_mapStyle);
                    _controller.complete(controller);
                  },
                  markers: _markers,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Clicking on map");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => MapWithMarkers(
                  //       alllocations: onelocation['locations'],
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  child: Text(''),
                ),
              )
            ],
          ),
          Container(
            height: 200.0,
            child: PageView.builder(
              controller: _pageviewcontroller,
              itemCount: pageviewlocationinfo.length,
              onPageChanged: (changedPageNo) async {
                print(changedPageNo);
                final GoogleMapController controller = await _controller.future;
                controller.showMarkerInfoWindow(MarkerId("$changedPageNo"));
              },
              itemBuilder: (BuildContext context, int index) {
                return pageviewlocationinfo[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
