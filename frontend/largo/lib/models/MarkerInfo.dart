class MarkerInfo {
  final int _placeId;
  final double _latitude;
  final double _longitude;

  MarkerInfo(this._placeId, this._latitude, this._longitude);

  factory MarkerInfo.fromJson(Map<String, dynamic> json) {
    return MarkerInfo(
      json['place_id'] as int,
      json['latitude'] as double,
      json['longitude'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['place_id'] = _placeId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }

  int get id => _placeId;
  double get latitude => _latitude;
  double get longitude => _longitude;


  @override
  String toString() {
    return 'PlaceInfo{_placeId: $_placeId, _latitude: $_latitude, _longitude: $_longitude}';
  }
}
