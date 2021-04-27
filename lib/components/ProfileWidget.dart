import 'package:flutter/material.dart';
import 'package:travelpointer/components/actor.dart';
import 'package:travelpointer/components/flatbuttoncomponent.dart';
import 'package:travelpointer/components/profileinfo.dart';
import 'package:travelpointer/screens/map.dart';

class ProfileWidget extends StatelessWidget {
  final user;
  ProfileWidget({this.user});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30.0),
          Row(
            children: [
              SizedBox(width: 30.0),
              Actor(size: 60.0),
              SizedBox(width: 30.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 7.0),
                    Text(
                      '${user.displayName}',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileInfo(
                            title: 'Trips',
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: ProfileInfo(
                            title: 'Followers',
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: ProfileInfo(
                            title: 'Rating',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 30.0),
            ],
          ),
          // SizedBox(height: 30.0),
          // Row(
          //   children: [
          //     SizedBox(width: 30.0),
          //     Expanded(child: FlatButtonComponent(buttonTitle: "Chat")),
          //     SizedBox(width: 30.0),
          //     Expanded(child: FlatButtonComponent(buttonTitle: "Follow")),
          //     SizedBox(width: 30.0),
          //   ],
          // ),
          SizedBox(height: 50.0),
          Expanded(
            child: MapSample(),
          ),
        ],
      ),
    );
  }
}
