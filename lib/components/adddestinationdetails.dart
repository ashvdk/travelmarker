import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddDestinationDetails extends StatefulWidget {
  final Function getPermissionToAddMarker;
  final Function addDestination;
  final LatLng lastMapPosition;
  final Function showmarkerinfowindow;
  AddDestinationDetails(
      {this.getPermissionToAddMarker,
      this.addDestination,
      this.lastMapPosition,
      this.showmarkerinfowindow});
  @override
  _AddDestinationDetailsState createState() => _AddDestinationDetailsState();
}

class _AddDestinationDetailsState extends State<AddDestinationDetails> {
  TextEditingController _nameoftheplacetexfieldController;
  TextEditingController _descriptionoftheplacetexfieldController;
  bool titleerror = false;
  @override
  void initState() {
    super.initState();
    _nameoftheplacetexfieldController = TextEditingController();
    _descriptionoftheplacetexfieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Divider(),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            controller: _nameoftheplacetexfieldController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name of the place (required)',
              errorText: titleerror ? "Cannot be empty" : null,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            controller: _descriptionoftheplacetexfieldController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description of the place (required)',
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          TextButton(
            child: Text(
              'Save the location',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_nameoftheplacetexfieldController.text.isEmpty) {
                setState(() {
                  titleerror = true;
                });
                return;
              }
              setState(() {
                titleerror = false;
              });
              var destination = {
                'name': _nameoftheplacetexfieldController.text,
                'description': _descriptionoftheplacetexfieldController.text,
                'coordinates': [
                  widget.lastMapPosition.latitude,
                  widget.lastMapPosition.longitude
                ]
              };
              widget.addDestination(destination);
              widget.getPermissionToAddMarker();
              widget.showmarkerinfowindow();
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
              minimumSize: Size(MediaQuery.of(context).size.width, 60),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    ));
  }
}
