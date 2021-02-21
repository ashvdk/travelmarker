import 'package:flutter/material.dart';

class CategoriesWithIcons extends StatefulWidget {
  @override
  _CategoriesWithIconsState createState() => _CategoriesWithIconsState();
}

class _CategoriesWithIconsState extends State<CategoriesWithIcons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.ev_station_rounded,
          size: 35.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'EV Station',
          style: TextStyle(fontSize: 10.0, color: Colors.grey),
        )
      ],
    );
  }
}
