import 'package:flutter/material.dart';

class FlatButtonComponent extends StatelessWidget {
  final String buttonTitle;
  FlatButtonComponent({this.buttonTitle});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color:
          buttonTitle == "Follow" ? Colors.lightBlueAccent : Colors.lightGreen,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.blueAccent,
      height: 50.0,
      onPressed: () {},
      child: Text(
        '$buttonTitle',
        style: TextStyle(fontSize: 13.0),
      ),
    );
  }
}
