import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String title;
  final int details;
  ProfileInfo({this.title, this.details});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$details',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            // color: Colors.white,
          ),
        ),
        Text(
          '$title',
          style: TextStyle(
            color: Colors.black38,
            fontSize: 10.0,
          ),
        )
      ],
    );
  }
}
