import 'package:flutter/material.dart';

class DestinationList extends StatefulWidget {
  final List destinations;
  DestinationList({this.destinations});
  @override
  _DestinationListState createState() => _DestinationListState();
}

class _DestinationListState extends State<DestinationList> {
  @override
  Widget build(BuildContext context) {
    return widget.destinations.length == 0
        ? Center(
            child: Text('No Destinations'),
          )
        : ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            itemCount: widget.destinations.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.destinations[index]['name']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${widget.destinations[index]['description']}')
                  ],
                ),
              );
            },
          );
  }
}
