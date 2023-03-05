class GeoLocationInfo {
  double latitude = 0.0;
  double longitude = 0.0;

  GeoLocationInfo({required this.latitude, required this.longitude});

  factory GeoLocationInfo.fromJson(Map<double, dynamic> json) {
    return GeoLocationInfo(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}