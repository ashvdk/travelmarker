import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MarkerImage extends ChangeNotifier {
  BitmapDescriptor waterfallmarker;
  BitmapDescriptor beachmarker;
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
  }

  BitmapDescriptor getMarkers(String category) {
    if (category == "Beach") {
      return beachmarker;
    } else if (category == "Waterfall") {
      return waterfallmarker;
    }
  }
}
