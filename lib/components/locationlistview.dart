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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLocationList();
  }

  // void getLocationList() {
  //
  //   setState(() {
  //     locationlist = [...alllocations];
  //   });
  // }

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
            Stack(
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width - 50.0,
                  height: 200.0,
                  child: GoogleMapLiteMode(
                    location: onelocation['locations'],
                    optimalZoom: onelocation['optimalZoom'],
                    optimalCoordinates: onelocation['optimalCoordinates'],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MapWithMarkers(
                          alllocations: onelocation['locations'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // width: MediaQuery.of(context).size.width - 50.0,
                    height: 100.0,
                    width: MediaQuery.of(context).size.width,
                    child: Text(''),
                  ),
                )
              ],
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
