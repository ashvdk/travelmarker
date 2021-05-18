import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseData extends ChangeNotifier {
  String token;
  void setToken() async {
    token = await FirebaseAuth.instance.currentUser.getIdToken(true);
  }
}
