import 'package:flutter/material.dart';
import 'package:travelpointer/components/actor.dart';
import 'package:travelpointer/components/googlemaplitemode.dart';
import 'package:travelpointer/screens/mapwithmarkers.dart';

class LocationListView extends StatefulWidget {
  final Map user;
  final List location;
  LocationListView({this.location, this.user});
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

  final GlobalKey _myWidgetState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var alllocations = [];
    for (var onelocation in widget.location) {
      alllocations.add(Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
              child: Row(
                children: [
                  Actor(size: 20.0, photoURL: widget.user['photoURL']),
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
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                "${onelocation['caption']}",
              ),
            ),
            // Stack(
            //   children: [
            Container(
              child: GoogleMapLiteMode(
                location: onelocation['locations'],
                optimalZoom: onelocation['optimalZoom'].toDouble(),
                optimalCoordinates: onelocation['optimalCoordinates'],
                markerid: markerid,
              ),
            ),
          ],
        ),
      ));
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
