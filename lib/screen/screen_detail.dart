import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:largo/details/top1.dart';
import 'package:largo/models/detail_model.dart';
import 'package:largo/providers/detail_provider.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/screen/screen_main.dart';
import 'package:largo/widget/market1.dart';
import 'package:largo/widget/market2.dart';
import 'package:largo/widget/market3.dart';
import 'package:largo/widget/market4.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:largo/models/detail_model.dart';

import '../main.dart';


class ScreenDetail extends StatelessWidget{
  final int homeData_id;

  ScreenDetail(@required this.homeData_id);

  Future <DetailModel> getJSONData() async {
    var url = Uri.parse('http://34.28.16.229:8080/api/v1/places/${homeData_id}');
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Color(0xffF5F5F5),
          leading:  IconButton(
            color : Color(0xff645F5A),
            onPressed:(){
              Navigator.pop(context);
            },
            icon : Icon(Icons.arrow_back_sharp),
          ),
          centerTitle: true, // 제목 중앙정렬 허용
          elevation: 0, // 그림자 없애기

        ),
      ),


      body: Container(
        width :double.infinity,
        margin: EdgeInsets.fromLTRB(23, 0, 23, 23),

        child:FutureBuilder<DetailModel>(
          future: getJSONData(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot <DetailModel>snapshot) {

            if (snapshot.hasError) {
              Text("${snapshot.error}");
            }else if (snapshot.hasData) {
              return  ListView(
                  children :[
                    Container(
                      width : double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        //color : Colors.red,
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                            image: NetworkImage(snapshot.data!.picture as String),
                            fit : BoxFit.fitWidth
                        ),

                      ),
                    ),
                    //api 호출 테스트 컨테이너
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 16, 0, 10),
                      width: double.infinity,
                      child: Text(
                        snapshot.data!.placeName,
                        style: TextStyle(
                            color : Color(0xff645F5A),
                            letterSpacing: -0.5,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700),),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 16),

                      child: Row(
                        children: [
                          Container(
                            height: 26,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              snapshot.data!.category,
                              style: TextStyle(
                                  color : Colors.white,
                                  letterSpacing: -0.8,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400),),
                            decoration: BoxDecoration(
                              color : Colors.grey,
                              borderRadius: BorderRadius.circular(3),
                            ),),
                          Container(
                            height: 26,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              snapshot.data!.hashtags1,
                              style: TextStyle(
                                  color : Colors.white,
                                  letterSpacing: -0.8,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400),),
                            decoration: BoxDecoration(
                              color : Colors.grey,
                              borderRadius: BorderRadius.circular(3),
                            ),



                          ),
                          Container(
                            height: 26,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              snapshot.data!.hashtags2,
                              style: TextStyle(
                                  color : Colors.white,
                                  letterSpacing: -0.8,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400),),
                            decoration: BoxDecoration(
                              color : Colors.grey,
                              borderRadius: BorderRadius.circular(3),
                            ),



                          ),

                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        snapshot.data!.info,
                        style: TextStyle(
                            color : Color(0xff645F5A),
                            letterSpacing: -0.5,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 36, 0, 11),

                      width: double.infinity,
                      child: Text(
                        '위치정보',
                        style: TextStyle(
                            color : Color(0xff645F5A),
                            letterSpacing: -0.5,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width : double.infinity,
                      padding: EdgeInsets.all(20),
                      height: 250,
                      decoration: BoxDecoration(
                        color : Colors.grey,
                        borderRadius: BorderRadius.circular(10),

                      ),


                    )
                  ]
              );
            };

            return CircularProgressIndicator();
          },
        ),



      ),
    );

  }
}




  

 







class TagBox extends StatelessWidget {
  String contents ='';
  final BorderRadius _baseBorderRadius = BorderRadius.circular(8);
  @override
  Widget build(BuildContext context) {
    String detail = contents;
    return Container(
      padding: EdgeInsets.all(5),
      width: 20,
      height: 26,
      color: Colors.white38,
      child: Text(
        detail,
        style: TextStyle(
            color : Colors.white,
            letterSpacing: -0.5,
            fontSize: 12.0,
            fontWeight: FontWeight.w400),
      ),

    );
  }
}





