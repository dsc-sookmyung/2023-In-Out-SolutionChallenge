/// place_id : "1"
/// place_name : "북서울 꿈의숲"
/// address_num : "강북구 번동 산28-6"
/// address_name : "강북구 월계로 173"
/// latitude : "37.6214312"
/// longitude : "127.0406246"
/// info : "북서울 꿈의 숲은 서울에서 4번째로 큰 공원입니다! 공원을 둘러싸는 길에는 벚꽃길을, 북쪽 아파트 지역과 인접한 곳에는 단풍숲이 있어요. 창녕위궁재사는 공원 동남쪽에 있으며, 주변에 연못과 정자(애련정) 등이 있답니다. 문화센터에는 300석 규모의 공연장 2개, 다목적홀, 전망대 등이 있어요."
/// category : "관광지"
/// picture : "https://ff3ebb6e6116a5cb4479830d52a191d1c2f7d561bd274da34f94934-apidata.googleusercontent.com/download/storage/v1/b/largo-storage/o/%E1%84%87%E1%85%AE%E1%86%A8%E1%84%89%E1%85%A5%E1%84%8B%E1%85%AE%E1%86%AF%E1%84%81%E1%85%AE%E1%86%B7%E1%84%8B%E1%85%B4%E1%84%89%E1%85%AE%E1%87%81.jpeg?jk=AahUMlv1NIsJQXVwpsMuBUN8L3jzzCixyEX2HOhDvOXnUx-_zisMo6WHaxtvQ96jhSmvPXB1IEnf0yqw7knEi54-1LirUUKdTHNfgeIhaisLadASjtVofkUIF-mWB33APaS_6W18KEu3XVuIqRg0DrzTPzla29IHxRCjaqJysfWQVrjQYAY71NKoTZxp_4XUuVL6yz2TzBxpIB0hVJb1SMEYN4MNTZt5UQOiLlXqgGpwd1_oMmT4Jndfz-RFVUmDHjATBYmDMn19WC_-PHsEY5psMyv50AjhCStV14A2-ojWBKcvragQJF3xyTLGHj2hNB5KZek5_2637wzhnCAK4heNZzl2h-JKNXE_zNLzdXdVbeHDXlcvowDeia3-Rzy2EPKTQEgyo1N5BIkF6WmPdbdTyC59PpubhLSDgBDO6AwKVrHlRWTB6sxZ_lrLpDAhbsuJzAHQolDXrt_1wrWb9pYBI5nYptMrladFYqUMP5KMoQ1amYlMGFG8kL8qzr5EnIHfT04QR8h86P3kJZy6W9P40RoGi5ryGo7Eo7snqL9rS3PLAaMJGDyc6orDsSQSeNSBrutGoXarXMZSPr7fPsyTQzjPBtQpiJfT22VyOSvlyGTcgjyyLrnkg9ifri8bzurx4oDJbOZwJhAkB9I_4Lt31UF0T4hY9Juw6zNZqyiAy77gp8HqiWZo-5P4uDBbN7DGPMCpxww8tZCw91q1QVHpvW3x0WM3E_xM8MWnRX_6JbzVaJ4oPRVy03mMMc6McOgaoVo54mdUB7J7TZPTry3GP2tdenYrbhrzKoeRKrpbGqXQlK0DyTmFIZlJvC0SdH34-MbVvJ-UjolQl1JftxJ79dHjIrQFOQUOvNXMPjnEHtuarZvIwvQgmLws7bz8-rhPC0gEq-8wB7cyiT5y5Yx4ltV1Y8KEzc9EeZK8QXMOalAXRYwAZUPbIxtVKRApFlZM0avZToLVGLkmHf9h5WMc0faunFKbBDz8gqBWT8pTG9wFyC5DBa3vH-IQ5ulYi8vtsQk5d41t7syso0eGutoGb3ui3Hx5tsfGtOMelOpyBflsVYPO7jwYadfchXw80fn14uwq1ZQQUZZFAbgetto_rzc0h08ZtqxZRCC1qv-lw7OciJs2OgmMqp9S5Ky2PYt8uV-phzN9kQbIXtURh6lRC-tMaL1W9ZA3_zHBgG97qiXmoOCYbsHiPPsv5WRjuPxPGTKOMfpJruSWVRLEgsJ7va9adajRvey4ciXZQ-McPAplkL2z4csjrQsh5W3WjLe4EdoGhlG6gmIGeqlr9fAtL9mIKl1Cr76REbIcnnFg-2xmw67EauFXuAW0w7AZrRgkkyAIpvwqDT1uhQG-U8VcM19ac7I8sfZtrjjoMrRn40Oq0m4&isca=1"

class PlaceInfo {
  PlaceInfo({
      String placeId, 
      String placeName, 
      String addressNum, 
      String addressName, 
      String latitude, 
      String longitude, 
      String info, 
      String category, 
      String picture,}){
    _placeId = placeId;
    _placeName = placeName;
    _addressNum = addressNum;
    _addressName = addressName;
    _latitude = latitude;
    _longitude = longitude;
    _info = info;
    _category = category;
    _picture = picture;
}

  PlaceInfo.fromJson(dynamic json) {
    _placeId = json['place_id'];
    _placeName = json['place_name'];
    _addressNum = json['address_num'];
    _addressName = json['address_name'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _info = json['info'];
    _category = json['category'];
    _picture = json['picture'];
  }
  String _placeId;
  String _placeName;
  String _addressNum;
  String _addressName;
  String _latitude;
  String _longitude;
  String _info;
  String _category;
  String _picture;
PlaceInfo copyWith({  String placeId,
  String placeName,
  String addressNum,
  String addressName,
  String latitude,
  String longitude,
  String info,
  String category,
  String picture,
}) => PlaceInfo(  placeId: placeId ?? _placeId,
  placeName: placeName ?? _placeName,
  addressNum: addressNum ?? _addressNum,
  addressName: addressName ?? _addressName,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  info: info ?? _info,
  category: category ?? _category,
  picture: picture ?? _picture,
);
  String get placeId => _placeId;
  String get placeName => _placeName;
  String get addressNum => _addressNum;
  String get addressName => _addressName;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get info => _info;
  String get category => _category;
  String get picture => _picture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['place_id'] = _placeId;
    map['place_name'] = _placeName;
    map['address_num'] = _addressNum;
    map['address_name'] = _addressName;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['info'] = _info;
    map['category'] = _category;
    map['picture'] = _picture;
    return map;
  }

}