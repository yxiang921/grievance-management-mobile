import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  double _latitude = 0;
  double _longitude = 0;

  double get latitude => _latitude;
  double get longitude => _longitude;

  Future<void> setLocation(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;

    notifyListeners();
    return Future.value();
  }

  Future<List<String>> getLocation() {
    return Future.value([_latitude.toString(), _longitude.toString()]);
  }
}
