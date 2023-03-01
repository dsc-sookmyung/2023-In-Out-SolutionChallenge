class GeoLocationInfo {
  final double latitude;
  final double longitude;

  GeoLocationInfo(
      {required this.latitude,
      required this.longitude,});

  factory GeoLocationInfo.fromJson(Map<double, dynamic> json) {
    return GeoLocationInfo(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}