import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String title;
  ProfileInfo({this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '25',
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
