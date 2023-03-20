import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// models
import 'package:largo/models/PlaceInfo.dart';
import 'package:largo/models/MarkerInfo.dart';

class APIService {
  Future<PlaceInfo> fetchPost(int placeId) async {
    final response =
        await http.get('http://34.64.143.243:8080/api/v1/places/${placeId}' as Uri);

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
        .get(Uri.parse('http://34.64.143.243:8080/api/v1/places')); //'https://jsonplaceholder.typicode.com/get/v1/places' as Uri);

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
}
