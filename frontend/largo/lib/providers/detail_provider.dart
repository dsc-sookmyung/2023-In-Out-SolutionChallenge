

import 'dart:convert';
import 'package:largo/models/detail_model.dart';

import 'package:http/http.dart' as http;

import '../main.dart';

class DetailProvider{
  List<DetailModel> detailList = [];

  Future <DetailModel> getDetail(int id) async {
    Uri uri = Uri.parse("http://34.64.143.243:8080/api/v1/places/$id");
    final response = await http.get(uri);
    if(response.statusCode == 200){
      String responseBody = utf8.decode(response.bodyBytes);
      var json = jsonDecode(responseBody);
      return json((detail) => new DetailModel.fromJson(detail));

    } else {
      throw Exception('Failed to load album');
    }

  }
}