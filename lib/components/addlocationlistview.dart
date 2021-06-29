import 'package:flutter/material.dart';
import 'package:travelpointer/components/googlemaplitemode.dart';

class AddLocationListView extends StatefulWidget {
  final List locations;
  final Function deleteonelocation;
  AddLocationListView({this.locations, this.deleteonelocation});

  @override
  _AddLocationListViewState createState() => _AddLocationListViewState();
}

class _AddLocationListViewState extends State<AddLocationListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.locations.length,
        itemBuilder: (context, index) {
          print(widget.locations[index]);
          return Container(
            padding: EdgeInsets.only(bottom: 10.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width - 50.0,
                  // height: 100.0,
                  child: GoogleMapLiteMode(
                    location: [widget.locations[index]],
                    optimalZoom: widget.locations[index]['optimalZoom'],
                    optimalCoordinates: widget.locations[index]
                        ['optimalCoordinates'],
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.only(
                //     top: 10.0,
                //     left: 10.0,
                //     right: 10.0,
                //     bottom: 10.0,
                //   ),
                //   child: Text("${widget.locations[index]['name']}"),
                // ),
                // Container(
                //   padding: const EdgeInsets.only(
                //     left: 10.0,
                //     right: 10.0,
                //     bottom: 10.0,
                //   ),
                //   child: Text("${widget.locations[index]['description']}"),
                // ),
                Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        var i = index;
                        widget.deleteonelocation(i);
                      },
                      child: Text(
                        'Remove this location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
