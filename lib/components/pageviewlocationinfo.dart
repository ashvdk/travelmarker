import 'package:flutter/material.dart';

class PageViewLocationInfo extends StatefulWidget {
  final Map marker;
  final Function incdecheightocontainer;
  PageViewLocationInfo({this.marker, this.incdecheightocontainer});
  @override
  _PageViewLocationInfoState createState() => _PageViewLocationInfoState();
}

class _PageViewLocationInfoState extends State<PageViewLocationInfo> {
  @override
  Widget build(BuildContext context) {
    var name = widget.marker['name'];
    var description = widget.marker['description'];
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dy > sensitivity) {
          widget.incdecheightocontainer(200.0);
          // Down Swipe
        } else if (details.delta.dy < -sensitivity) {
          widget.incdecheightocontainer(400.0);
          print("swiped up");
          // Up Swipe
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${name}",
                style: TextStyle(fontSize: 25.0),
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
      ),
    );
  }
}
