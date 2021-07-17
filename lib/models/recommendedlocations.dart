import 'package:flutter/foundation.dart';

class Recommendedlocations extends ChangeNotifier {
  List _recommendedlocations = [];
  void setRecommendedLocations(List recommendedlocations) {
    _recommendedlocations.addAll(recommendedlocations);
    notifyListeners();
  }

  List get getLocations {
    return _recommendedlocations;
  }
}
