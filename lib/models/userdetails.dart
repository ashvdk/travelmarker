import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserDetails extends ChangeNotifier {
  var userdetails;
  void setUserDetails(Map user_details) {
    userdetails = user_details;
  }
}
