
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GPSInfoㄴ {
  static final GPSInfoProvider _instance = GPSInfoProvider._internal();
  static final StreamController<Position> _controller = StreamController<Position>.broadcast();

  StreamController<Position> get controller => _controller;

  factory GPSInfoProvider() {
    return _instance;
  }

  GPSInfoProvider._internal() {
    Geolocator.getPositionStream().listen((Position position) {
      _controller.add(position);
    });
  }

}