
class PlaceModel {
  int place_id;
  String place_name;
  String picture;
  List hashtags;
  String address;

  PlaceModel(
     this.place_id,
     this.place_name,
     this.picture,
     this.hashtags,
     this.address,
  );

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      json['place_id'] as int,
      json['place_name'],
      json['picture'],
      json['hashtags'] as List,
      json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['place_id'] = place_id;
    map['place_name'] = place_name;
    map['picture'] = picture;
    map['hashtags'] = hashtags;
    map['address'] = address;
    return map;
  }


}
