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
  @override
  Widget build(BuildContext context) {
    print(widget.location);
    return widget.location.length == 0
        ? Center(
            child: Text('No trips yet'),
          )
        : ListView.builder(
            itemCount: widget.location.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(bottom: 10.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, bottom: 10.0, top: 10.0),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('went on journey')
                                  ],
                                ),
                                Text('25 Aug 2021')
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.thumb_up),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.thumb_down),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: Text(
                            "${widget.location[index]['caption']}",
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              // width: MediaQuery.of(context).size.width - 50.0,
                              height: 100.0,
                              child: GoogleMapLiteMode(coordinates: null),
                            ),
                            GestureDetector(
                              onTap: () {
                                print(widget.location[index]['locations']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MapWithMarkers(
                                      alllocations: widget.location[index]
                                          ['locations'],
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
                    )
                  ],
                ),
              );
            });
  }
}
