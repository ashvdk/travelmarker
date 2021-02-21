import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelpointer/components/actor.dart';
import 'package:travelpointer/screens/map.dart';

class FeedUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          Row(
            children: [
              SizedBox(width: 10.0),
              Actor(size: 30.0),
              SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ashwin Rao K',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Went on a journey to explore the beautiful place MYSORE',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10.0),
          MapSample(),
        ],
      ),
    );
  }
}
