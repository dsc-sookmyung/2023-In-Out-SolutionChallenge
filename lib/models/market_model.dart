
class MarketModel {
  int market_id;
  String market_name;
  String address_name;
  double longitude;
  double latitude;
  String? picture;

  MarketModel(this.market_id,
     this.market_name,
     this.address_name,
     this.longitude,
     this.latitude,
     this.picture,
  );


  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
      json['market_id'] as int,
      json['market_name'],
      json['address_name'],
      json['longitude'] as double,
      json['latitude'] as double,
      json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['market_id'] = market_id;
    map['market_name'] = market_name;
    map['address_name'] = address_name;
    map['latitude'] = latitude;
    map['longitude'] = latitude;
    map['picture'] = picture;
    return map;
  }



}
