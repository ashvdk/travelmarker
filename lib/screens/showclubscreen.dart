import 'package:flutter/material.dart';
import 'package:travelpointer/screens/planyourtripscreen.dart';

class ShowClubScreen extends StatefulWidget {
  final Map clubinfo;
  ShowClubScreen({this.clubinfo});
  @override
  _ShowClubScreenState createState() => _ShowClubScreenState();
}

class _ShowClubScreenState extends State<ShowClubScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.clubinfo);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.clubinfo['clubname']}',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '@${widget.clubinfo['clubcategory']}',
                style: TextStyle(fontSize: 20.0),
              ),
              Text('${widget.clubinfo['clubdescription']}'),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                child: Text(
                  'Plan a Trip',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PlanYourTripScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  backgroundColor: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
