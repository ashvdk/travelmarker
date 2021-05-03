import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';

class AllData extends ChangeNotifier {
  List _markersOfCities = [];

  List get getMarkers {
    return _markersOfCities;
  }

  void setMarkers(List markers) async {
    print("came to provider");
    _markersOfCities = [..._markersOfCities, ...markers];
    notifyListeners();
    // for (var marker in markers) {
    //   var city = marker['city'];
    //   if (_markersOfCities[city] == null) {
    //     var addresses = await Geocoder.local.findAddressesFromQuery(city);
    //     var first = addresses.first;
    //     _markersOfCities[city] = {
    //       'city': city,
    //       'coordinates': [
    //         first.coordinates.latitude,
    //         first.coordinates.longitude
    //       ],
    //       'locations': [marker]
    //     };
    //   } else {
    //     var getlocations = [..._markersOfCities[city]['locations']];
    //     getlocations.add(marker);
    //     _markersOfCities[city]['locations'] = [...getlocations];
    //   }
    // }
  }
}
