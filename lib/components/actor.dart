import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Actor extends StatelessWidget {
  final String photoURL;
  final double size;
  Actor({this.size, this.photoURL});
  var url = FirebaseAuth.instance.currentUser.photoURL;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: photoURL == null
          ? AssetImage('assets/avatar.jpg')
          : NetworkImage(
              '$photoURL',
            ),
    );
  }
}
