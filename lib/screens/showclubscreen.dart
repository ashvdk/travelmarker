import 'package:flutter/material.dart';
import 'package:travelpointer/screens/planyourtripscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blueAccent,
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              child: Image.asset("assets/leadingroad.jpg", fit: BoxFit.cover),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.clubinfo['clubname']}',
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              '@${widget.clubinfo['clubcategory']}',
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                      FirebaseAuth.instance.currentUser.uid ==
                              widget.clubinfo['uid']
                          ? Container()
                          : GestureDetector(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 2, bottom: 2),
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.pink[50],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.thumb_up_alt,
                                      color: Colors.pink,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "Like",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                      child: Text(
                    '${widget.clubinfo['clubdescription']}',
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(
                    height: 20.0,
                  ),
                  FirebaseAuth.instance.currentUser.uid ==
                          widget.clubinfo['uid']
                      ? TextButton(
                          child: Text(
                            'Plan a Trip',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PlanYourTripScreen(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
