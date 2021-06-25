import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MarkerImage extends ChangeNotifier {
  BitmapDescriptor waterfallmarker;
  BitmapDescriptor beachmarker;
  BitmapDescriptor restaurantmarker;
  BitmapDescriptor hinduTempleMarker;
  BitmapDescriptor themeParkMarker;
  BitmapDescriptor parkMarker;
  void setMarkers() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
            'assets/icons8-waterfall-48.png')
        .then((onValue) {
      waterfallmarker = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
            'assets/icons8-beach-100.png')
        .then((onValue) {
      beachmarker = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
            'assets/icons8-restaurant-100.png')
        .then((onValue) {
      restaurantmarker = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
            'assets/icons8-hindu-temple-96.png')
        .then((onValue) {
      hinduTempleMarker = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
            'assets/icons8-national-park-100.png')
        .then((onValue) {
      parkMarker = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(48, 48)),
            'assets/icons8-theme-park-96.png')
        .then((onValue) {
      themeParkMarker = onValue;
    });
  }

  BitmapDescriptor getMarkers(String category) {
    if (category == "Beach") {
      return beachmarker;
    } else if (category == "Waterfall") {
      return waterfallmarker;
    } else if (category == "Restaurant") {
      return restaurantmarker;
    } else if (category == "Temple") {
      return hinduTempleMarker;
    } else if (category == "Theme Park") {
      return themeParkMarker;
    } else if (category == "Park") {
      return parkMarker;
    }
  }
}
