import 'package:flutter/material.dart';

class PlanYourTripScreen extends StatefulWidget {
  @override
  _PlanYourTripScreenState createState() => _PlanYourTripScreenState();
}

class _PlanYourTripScreenState extends State<PlanYourTripScreen> {
  TextEditingController _tripnametexfieldController;
  TextEditingController _tripdescriptiontexfieldController;

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
            ],
          ),
        ),
      ),
    );
  }
}
