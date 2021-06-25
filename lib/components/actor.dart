import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/models/userdetails.dart';

class Actor extends StatelessWidget {
  final String photoURL;
  final double size;
  Actor({this.size, this.photoURL});
  var url = FirebaseAuth.instance.currentUser.photoURL;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserDetails>(context).userdetails;
    return CircleAvatar(
      radius: size,
      backgroundColor: Colors.white,
      backgroundImage: photoURL == null
          ? user['gender'] == "male"
              ? AssetImage('assets/avatar.jpg')
              : AssetImage('assets/icons8-person-female-96.png')
          : NetworkImage(
              '$photoURL',
            ),
    );
  }
}
