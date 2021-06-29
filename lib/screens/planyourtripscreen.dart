import 'package:flutter/material.dart';
import 'package:travelpointer/screens/adddestination.dart';

class PlanYourTripScreen extends StatefulWidget {
  @override
  _PlanYourTripScreenState createState() => _PlanYourTripScreenState();
}

class _PlanYourTripScreenState extends State<PlanYourTripScreen> {
  TextEditingController _tripnametexfieldController;
  TextEditingController _tripdescriptiontexfieldController;
  var destinations = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    _tripnametexfieldController = TextEditingController();
    _tripdescriptiontexfieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Plan Your Trip",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Divider(),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _tripnametexfieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Trip name (required)',
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _tripdescriptiontexfieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Trip Description (required)',
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddDestination(),
                    ),
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.pink[50],
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.pink,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Add Destinations",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
