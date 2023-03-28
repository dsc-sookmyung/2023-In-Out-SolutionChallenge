import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// models
import 'package:largo/models/PlaceInfo.dart';
import 'package:largo/models/MarkerInfo.dart';

import '../models/detail_model.dart';
import '../screen/screen_login.dart';

class APIService {

  Future<PlaceInfo> fetchPost(int placeId) async {
    final response =
        await http.get('http://34.64.143.243:8080/api/v1/places/${placeId}' as Uri, headers: {'X-Auth-Token': tokenTest});

    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      return PlaceInfo.fromJson(json.decode(response.body));
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }

  Future<List<MarkerInfo>> fetchMarkers() async {
    final response = await http
        .get(Uri.parse('http://34.64.143.243:8080/api/v1/places'), headers: {'X-Auth-Token': tokenTest});

    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다. 37.544808, 126.965539 37.545658, 126.964842
      // var testData = '''[
      //   {"id": 1, "lon": 126.965539, "lat": 37.544808},
      //   {"id": 2, "lon": 126.964842, "lat": 37.545658}]''';


      //return MarkerInfo.fromJson(json.decode(response.body));
      //return MarkerInfo.fromJson(json.decode(testData));
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<MarkerInfo> infos = items.map<MarkerInfo>((json) {
        return MarkerInfo.fromJson(json);
      }).toList();

      return infos;
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }

  Future<PlaceInfo> fetchPlaceInfo(double lat, double long, List<int> placeId) async {
    print("fetchPlaceInfo***********************************************");
    var postUri = Uri.parse('http://34.64.143.243:8080/api/v1/places/search');
    Map<String, dynamic> body = {"latitude": lat, "longitude": long,'exclusions': placeId};

    print(body.toString());

    final headers = {'Content-Type': 'application/json', 'X-Auth-Token': tokenTest};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('UTF-8');
    final response = await http.post(
      postUri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      final items = json.decode(utf8.decode(response.bodyBytes)).cast<String,dynamic>();

      if(items["place_id"] != null) {
        PlaceInfo infos = PlaceInfo.fromJson_explain(items);

        return infos;
      }else {
        throw Exception("주변 탐색 가능 장소 없음");
      }
    }else {
      throw Exception('Failed to load post');
    }
  }

  Future<String> uploadImage(String path, Uint8List data) async {
    print("uploadImage***********************************************");
    var postUri = Uri.parse('http://34.64.143.243:8080/api/v1/files');
    //var request = http.MultipartRequest("POST", postUri);

    //request.headers['Accept'] = "application/json";
    //request.headers['Content-Type'] = "application/x-www-form-urlencoded";

    Map<String, dynamic> body = {'path': path, 'file': data};

    final headers = {'Content-Type': 'application/json', 'X-Auth-Token': tokenTest};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
      postUri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      print ("DB URL : ${response.body}");
      print("Image UpLoad 성공");
      return response.body;
    }else {
      print("Image UpLoad 실패");
      print("res : ${response.statusCode}");
      return "";
    }
  }

  Future<void> uploadRunData(List<LatLng> gps, String time, double dist, String map_picture, List<String> user_picture ) async {
    print("uploadRunData***********************************************");
    var postUri = Uri.parse('http://34.64.143.243:8080/api/v1/courses');

    var gps_temp = [];
    for(int i = 0; i < gps.length; i++) {
      Map<String, dynamic> temp = {"lat": gps[i].latitude, "lon": gps[i].longitude};
      gps_temp.add(temp);
    }

    Map<String, dynamic> body = {'ls': gps_temp, 'total_time': time, 'total_dist': dist, 'map_picture':map_picture, 'user_picture': user_picture};

    print(body.toString());

    final headers = {'Content-Type': 'application/json', 'X-Auth-Token': tokenTest};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    final response = await http.post(
      postUri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      print("Data UpLoad 성공");
    }else {
      print("Image UpLoad 실패");
      print("res : ${response.statusCode}");
      throw Exception('Failed to load post');
    }
  }

  Future <DetailModel> getPlaceData(int place_id) async {
    var url = Uri.parse('http://34.64.143.243:8080/api/v1/places/${place_id}');
    http.Response response;
    var data;
    List<DetailModel> details =[];
    List<String> test =[];
    DetailModel detail;
    try{
      response = await http.get(url,headers: {
        // 임시, 로컬 저장소로 바꿔줘야 함.
        'X-Auth-Token': tokenTest
      });
      data = await json.decode(utf8.decode(response.bodyBytes));
      detail = DetailModel(
          placeId: data["place_id"].toString(),
          placeName: data["place_name"].toString(),
          addressNum: data["address_num"].toString(),
          addressName: data["address_name"].toString(),
          longitude: data["longitude"].toString(),
          latitude: data["latitude"].toString(),
          info: data["info"].toString(),
          category: data["category"].toString(),
          picture: data["picture"].toString(),
          hashtags1:data["hashtags"][0],
          hashtags2:data["hashtags"][1]

      );

      test.add(data["place_name"]);
      print(detail.placeName);
      return detail;
    } catch(e){
      print(e);
      rethrow;
    }
  }
}
