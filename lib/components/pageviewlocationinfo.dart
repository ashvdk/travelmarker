import 'package:flutter/material.dart';

class PageViewLocationInfo extends StatefulWidget {
  final Map marker;
  PageViewLocationInfo({this.marker});
  @override
  _PageViewLocationInfoState createState() => _PageViewLocationInfoState();
}

class _PageViewLocationInfoState extends State<PageViewLocationInfo> {
  @override
  Widget build(BuildContext context) {
    var name = widget.marker['name'];
    var description = widget.marker['description'];
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${name}",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "${description}",
            ),
          ],
        ),
      ),
    );
  }
}
