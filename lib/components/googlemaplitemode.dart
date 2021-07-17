import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/models/markerimage.dart';
import 'package:travelpointer/screens/mapwithmarkers.dart';
import 'package:travelpointer/screens/photoshowui.dart';
import 'package:image_picker/image_picker.dart';

class GoogleMapLiteMode extends StatefulWidget {
  final List location;
  final double optimalZoom;
  final List optimalCoordinates;
  final int markerid;
  final bool liteModeEnabled;
  final Function setSettings;
  GoogleMapLiteMode({
    this.location,
    this.optimalZoom,
    this.optimalCoordinates,
    this.markerid,
    this.liteModeEnabled,
    this.setSettings,
  });
  @override
  _GoogleMapLiteModeState createState() => _GoogleMapLiteModeState();
}

class _GoogleMapLiteModeState extends State<GoogleMapLiteMode> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  List<Widget> pageviewlocationinfo = [];
  List<Widget> carasoueldot = [];
  PageController _pageviewcontroller;
  int selectedlocationdot = 0;
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
    final LatLng _center =
        LatLng(widget.optimalCoordinates[0], widget.optimalCoordinates[1]);
    final CameraPosition _kGooglePlex = CameraPosition(
      target: _center,
      zoom: widget.optimalZoom,
    );
    Set<Marker> tempMarkers = {};
    var i = 0;
    List<Widget> pageviewlocationinfoTemp = [];
    List<Widget> caracouseldottemp = [];
    for (var marker in widget.location) {
      print(marker['filepath']);
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
      caracouseldottemp.add(
        Column(
          children: [
            Container(
              width: 5.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: selectedlocationdot == i
                    ? Color(0xff3722d3)
                    : Color(0xffcccccc),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
      );
      pageviewlocationinfoTemp.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
        ),
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              "${marker['name']}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text(
              '${marker['description'].length > 106 ? marker['description'].substring(0, 107) : marker['description']}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: marker['filepath'].length == 0
                      ? marker['downloadurls'].map<Widget>((e) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PhotoSHowUI(photourl: e),
                                ),
                              );
                            },
                            child: Container(
                              width: 70.0,
                              height: 70.0,
                              color: Colors.red,
                              child: Image.network(
                                "$e",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList()
                      : marker['filepath'].map<Widget>((e) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PhotoSHowUI(photourl: e.path),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.red,
                              child: Image.file(
                                File(e.path),
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                ),
              ),
            ),
          ],
        ),
      ));
      i++;
    }
    setState(() {
      _markers = {...tempMarkers};
      pageviewlocationinfo = [...pageviewlocationinfoTemp];
      carasoueldot = [...caracouseldottemp];
    });
    _pageviewcontroller = PageController(
      initialPage: 0,
    );
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  liteModeEnabled: widget.liteModeEnabled,
                  onCameraMove: _onCameraMove,
                  onMapCreated: (GoogleMapController controller) {
                    // controller.setMapStyle(_mapStyle);
                    _controller.complete(controller);
                  },
                  markers: _markers,
                ),
              ),
              widget.liteModeEnabled
                  ? GestureDetector(
                      onTap: () {
                        print("Clicking on map");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MapWithMarkers(alllocations: widget.location),
                          ),
                        );
                      },
                      child: Container(
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        child: Text(''),
                      ),
                    )
                  : Container()
            ],
          ),
          Container(
            height: 230.0,
            child: PageView.builder(
              controller: _pageviewcontroller,
              itemCount: pageviewlocationinfo.length,
              onPageChanged: (changedPageNo) async {
                print(changedPageNo);
                setState(() {
                  selectedlocationdot = changedPageNo;
                });
                final GoogleMapController controller = await _controller.future;
                controller.showMarkerInfoWindow(MarkerId("$changedPageNo"));
              },
              itemBuilder: (BuildContext context, int index) {
                return pageviewlocationinfo[index];
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [...carasoueldot],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
