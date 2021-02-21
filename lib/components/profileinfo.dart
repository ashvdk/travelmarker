import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String title;
  ProfileInfo({this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10.0,
          ),
        ),
        Text(
          '25',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
