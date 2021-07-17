import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/components/actor.dart';
import 'package:travelpointer/components/flatbuttoncomponent.dart';
import 'package:travelpointer/components/googlemaplitemode.dart';
import 'package:travelpointer/components/locationlistview.dart';
import 'package:travelpointer/components/profileinfo.dart';
import 'package:travelpointer/components/userfollowbuttoncomponent.dart';
import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/models/userdetails.dart';
import 'package:travelpointer/screens/map.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  var relationship_id = null;
  void addrelationship(String relationshipid) {
    setState(() {
      relationship_id = relationshipid;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserDetails>(context).userdetails;
    var locations = Provider.of<AllData>(context, listen: true).getMarkers;
    return Container(
      color: Color(0xfff4f4f4),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.blueAccent,
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  child:
                      Image.asset("assets/leadingroad.jpg", fit: BoxFit.cover),
                ),
                Row(
                  children: [
                    SizedBox(width: 20.0),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Text(
                              '${user['displayName']}',
                              style: TextStyle(
                                fontSize: 30.0, fontFamily: 'Quicksand',
                                // color: Colors.white,
                              ),
                            ),
                            Text(
                              '@${user['username']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Quicksand',
                                // color: Color(0xFFa5d2b1),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProfileInfo(
                                    title: 'Locations',
                                    details: locations.length),
                                ProfileInfo(
                                    title: 'Followers',
                                    details: locations.length),
                                ProfileInfo(
                                    title: 'Following',
                                    details: locations.length),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  child: user['_id'] != FirebaseAuth.instance.currentUser.uid
                      ? Column(
                          children: [
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                UserFollowButtonComponent(
                                  user: user,
                                  addrelationship: addrelationship,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                relationship_id != null
                                    ? IconButton(
                                        onPressed: () {},
                                        color: Colors.black,
                                        icon: Icon(
                                          Icons.chat,
                                          size: 26.0,
                                          color: Color(0xFF05a859),
                                        ),
                                      )
                                    : Text('')
                              ],
                            ),
                            SizedBox(height: 5.0)
                          ],
                        )
                      : SizedBox(height: 15.0),
                ),
                SizedBox(height: 40.0),
                Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Me',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "${user['description']}",
                          style: TextStyle(fontSize: 17.0),
                          //textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Text(
                    'Destinations',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: LocationListView(
                    user: user,
                    location: locations,
                    liteModeEnabled: true,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 250.0,
              left: 20.0,
              child: Actor(size: 50.0, user: user),
            ),
            Positioned(
              top: 250.0,
              right: 20.0,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
