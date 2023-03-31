

// 상세정보

class DetailModel {
  late String placeId;
  late String placeName;
  late String addressNum;
  late String addressName;
  late String longitude;
  late String latitude;
  late String info;
  late String category;
  late String picture;
  late String hashtags1;
  late String hashtags2;




  DetailModel({
    required this.placeId,
    required this.placeName,
    required this.addressNum,
    required this.addressName,
    required this.longitude,
    required this.latitude,
    required this.info,
    required this.category,
    required this.picture,
    required this.hashtags1,
    required this.hashtags2,



  });

  factory DetailModel.fromJson (Map<String, dynamic> json) {
    return DetailModel(
      placeId: json['place_id'],
      placeName: json['place_name'],
      addressNum: json['address_num'],
      addressName: json['address_name'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      info: json['info'],
      category: json['category'],
      picture: json['picture'],
      hashtags1: json['hashtags'][0],
      hashtags2: json['hashtags'][1],

    );

  }

}
