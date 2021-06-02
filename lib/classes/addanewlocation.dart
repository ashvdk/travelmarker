import 'package:flutter/foundation.dart';

class AddANewLocation extends ChangeNotifier {
  List _currentLocationData = [];
  String _category = "";
  String _title = "";
  String _description = "";
  void setSaveCurrentLocation(List latLng) {
    _currentLocationData = [latLng[0], latLng[1]];
  }

  void setCategory(String categoryType) {
    _category = categoryType;
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
