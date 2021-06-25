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
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.blueAccent,
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                child: Image.asset("assets/leadingroad.jpg", fit: BoxFit.cover),
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
                              ),
                              ProfileInfo(
                                title: 'Followers',
                              ),
                              ProfileInfo(
                                title: 'Rating',
                              ),
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
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "${user['description']}",
                  textAlign: TextAlign.center,
                ),
              ),
              LocationListView(
                user: user,
                location:
                    Provider.of<AllData>(context, listen: true).getMarkers,
              ),
            ],
          ),
          Positioned(
            top: 250.0,
            left: 20.0,
            child: Actor(size: 50.0, photoURL: user['photoURL']),
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
    );
  }
}
