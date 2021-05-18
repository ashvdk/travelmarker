import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/components/actor.dart';
import 'package:travelpointer/components/flatbuttoncomponent.dart';
import 'package:travelpointer/components/profileinfo.dart';
import 'package:travelpointer/components/userfollowbuttoncomponent.dart';
import 'package:travelpointer/models/userdetails.dart';
import 'package:travelpointer/screens/map.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserDetails>(context).userdetails;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Actor(size: 60.0),
                SizedBox(height: 20.0),
                Text(
                  '${user['displayName']}',
                  style: TextStyle(
                    fontSize: 30.0,
                    // color: Colors.white,
                  ),
                ),
                Text(
                  '@${user['username']}',
                  style: TextStyle(
                    fontSize: 13.0,
                    // color: Color(0xFFa5d2b1),
                  ),
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
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  color: Colors.black,
                                  icon: Icon(
                                    Icons.chat,
                                    size: 26.0,
                                    color: Color(0xFF05a859),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5.0)
                          ],
                        )
                      : SizedBox(height: 15.0),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Color(0xFF05a859),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileInfo(
                  title: 'Trips',
                ),
                ProfileInfo(
                  title: 'Followers',
                ),
                ProfileInfo(
                  title: 'Rating',
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     SizedBox(width: 30.0),
          //     Actor(size: 60.0),
          //     SizedBox(width: 30.0),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SizedBox(height: 7.0),
          //           Text(
          //             '${user['displayName']}',
          //             style: TextStyle(
          //               fontSize: 30.0,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           SizedBox(
          //             height: 10.0,
          //           ),

          //         ],
          //       ),
          //     ),
          //     SizedBox(width: 30.0),
          //   ],
          // ),
          Expanded(
            child: MapSample(),
          ),
        ],
      ),
    );
  }
}
