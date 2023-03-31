import 'dart:convert';
import 'package:largo/screen/screen_detail.dart';
import 'package:largo/screen/screen_main.dart';
import 'package:largo/widget/search_bar.dart';
import 'package:flutter/material.dart';
//상세정보
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/detail_model.dart';

var response;

class ScreenSearch extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ScreenSearch> {
  Future<List<DetailModel>> getAPI_search() async {
    print("loggg1");
    http.Response response;
    List<DetailModel> searchResults = [];
    DetailModel result;
    var data;
    var url = Uri.parse('http://34.28.16.229:8080/api/v1/places/test');
    final user = await SharedPreferences.getInstance();
    response = await http.get(url, headers: {
      // 임시, 로컬 저장소로 바꿔줘야 함.
      'X-Auth-Token': user.getString('token') ?? [].toString()
    });

    try {
      data = await json.decode(utf8.decode(response.bodyBytes)) as List;
      // 전 지역 top5의 장소를 리스트에 저장하기 (place_model 형태)

      for (int i = 0; i < data.length; i++) {
        result = DetailModel(
            placeId: data[i]["place_id"].toString(),
            placeName: data[i]["place_name"].toString(),
            addressNum: data[i]["address_num"].toString(),
            addressName: data[i]["address_name"].toString(),
            longitude: data[i]["longitude"].toString(),
            latitude: data[i]["latitude"].toString(),
            info: data[i]["info"].toString(),
            category: data[i]["category"].toString(),
            picture: data[i]["picture"].toString(),
            hashtags1: data[i]["hashtags"][0].toString(),
            hashtags2: data[i]["hashtags"][1].toString());
        searchResults.add(result);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    return searchResults;
  }

  @override
  void initState() {
    super.initState();
   //getJSONData();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'notosanskr',
        ),
        home: Scaffold(
            backgroundColor: Color(0xffF5F5F5),
            body: Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 20, 23, 23),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: IconButton(
                            color: Color(0xff645F5A),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScreenMain()));
                            },
                            icon: Icon(Icons.arrow_back_sharp),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            onSubmitted: (text) {},
                            onChanged: (text) {},
                            decoration: InputDecoration(
                              // labelText: '텍스트 입력',
                              filled: true,
                              fillColor: Color(0xfaffc977),

                              hintText: '검색할 장소를 입력하세요!',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    width: 3, color: Color(0xfaffc977)),
                              ), //외곽선

                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                    width: 3, color: Color(0xfaffc977)),
                              ), //외곽선
                            ),
                            cursorColor: Colors.black,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              search = 1;
                            },
                            icon: Icon(
                              Icons.search_rounded,
                            ))
                      ],
                    ),
                    SearchBar()
                  ],
                ))));
  }
}
