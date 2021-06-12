import 'package:flutter/material.dart';
import 'package:travelpointer/screens/addnewclubscreen.dart';
import 'package:travelpointer/screens/showclubscreen.dart';

class ClubListComponent extends StatefulWidget {
  final List clubs;
  ClubListComponent({this.clubs});
  @override
  _ClubListComponentState createState() => _ClubListComponentState();
}

class _ClubListComponentState extends State<ClubListComponent> {
  @override
  Widget build(BuildContext context) {
    print(widget.clubs);
    return ListView.builder(
      itemCount: widget.clubs.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ShowClubScreen(
                  clubinfo: widget.clubs[index],
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.clubs[index]['clubname']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${widget.clubs[index]['clubdescription']}')
              ],
            ),
          ),
        );
      },
    );
  }
}
