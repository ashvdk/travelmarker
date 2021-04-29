import 'package:flutter/foundation.dart';
import 'dart:ffi';

class AddANewLocation extends ChangeNotifier {
  List _currentLocationData = [];
  String _category = "";
  String _title = "";
  String _description = "";
  void setSaveCurrentLocation(List latLng) {
    _currentLocationData = [latLng[0], latLng[1]];
    print(_currentLocationData);
  }

  void setCategory(String categoryType) {
    _category = categoryType;
    print(_currentLocationData);
    print(_category);
  }

  void setTitleDescription(String title, String description) {
    _title = title;
    _description = description;
  }

  Map get newLocationInfo {
    return {
      "name": _title,
      "description": _description,
      "coordinates": _currentLocationData.join(", "),
      "category": _category,
      "city": "unknown"
    };
  }
}