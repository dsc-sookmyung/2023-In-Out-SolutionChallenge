
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:largo/models/userLocationInfo.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  static final StreamController<Position> _locationController = StreamController<Position>.broadcast();
  final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 3, // gps update event call 조건 m단위 -> 몇 m 마다 호출할 것인가
  );

  StreamController<Position> get controller => _locationController;

  factory LocationService() {
    return _instance;
  }

  LocationService._internal() {
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      _locationController.add(position);
      print("GPS position : ${position.latitude}, ${position.longitude}");
    });
  }
}