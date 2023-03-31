import 'dart:ffi';
import 'package:largo/models/userLocationInfo.dart';

class NewLocationViewModel {
  UserLocationInfo _newLocation;

  NewLocationViewModel({required UserLocationInfo newLocation}) : _newLocation = newLocation;

  double get latitude {
    return _newLocation.latitude;
  }

  double get longitude {
    return _newLocation.longitude;
  }

  set latitude(double lat) {
    this._newLocation.latitude = lat;
  }

  set longitude(double long) {
    this._newLocation.longitude = long;
  }
}