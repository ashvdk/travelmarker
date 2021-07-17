import 'package:flutter/material.dart';

class Actor extends StatelessWidget {
  final Map user;
  final double size;
  Actor({this.size, this.user});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: Colors.white,
      backgroundImage: user['photoURL'] == null
          ? user['gender'] == "male"
              ? AssetImage('assets/avatar.jpg')
              : AssetImage('assets/icons8-person-female-96.png')
          : NetworkImage(
              '${user['photoURL']}',
            ),
    );
  }
}
