import 'package:flutter/material.dart';
import 'package:travelpointer/components/actor.dart';
import 'package:travelpointer/components/googlemaplitemode.dart';

class LocationListView extends StatefulWidget {
  final Map user;
  final List location;
  final bool liteModeEnabled;
  final Function setSettings;
  LocationListView(
      {this.location, this.user, this.liteModeEnabled, this.setSettings});
  @override
  _LocationListViewState createState() => _LocationListViewState();
}

class _LocationListViewState extends State<LocationListView> {
  var locationlist = [];
  PageController _pageviewcontroller;
  var markerid = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageviewcontroller = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var alllocations = [];
    for (var onelocation in widget.location) {
      alllocations.add(
        ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.greenAccent[200],
              //     offset: const Offset(
              //       5.0,
              //       5.0,
              //     ),
              //     blurRadius: 10.0,
              //     spreadRadius: 2.0,
              //   ), //BoxShadow
              //   BoxShadow(
              //     color: Colors.white,
              //     offset: const Offset(0.0, 0.0),
              //     blurRadius: 0.0,
              //     spreadRadius: 0.0,
              //   ), //BoxShadow
              // ],
            ),
            margin: EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    bottom: 10.0,
                    top: 10.0,
                  ),
                  child: Row(
                    children: [
                      Actor(size: 20.0, user: widget.user),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${widget.user['displayName']} ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('went on journey')
                              ],
                            ),
                            Text('25 Aug 2021')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "${onelocation['caption']}",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Container(
                  child: GoogleMapLiteMode(
                    location: onelocation['locations'],
                    optimalZoom: onelocation['optimalZoom'].toDouble(),
                    optimalCoordinates: onelocation['optimalCoordinates'],
                    markerid: markerid,
                    liteModeEnabled: widget.liteModeEnabled,
                    setSettings: widget.setSettings,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return widget.location.length == 0
        ? Center(
            child: Text('No trips yet'),
          )
        : Column(
            children: [...alllocations],
          );
  }
}
