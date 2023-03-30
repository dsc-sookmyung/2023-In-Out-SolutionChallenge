import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:largo/color/themeColors.dart';

import '../screen/screen_detail.dart';
import '../screen/screen_home.dart';
import '../screen/screen_main.dart';
//상세정보
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/detail_model.dart';
int search = 0;

class SearchBar extends StatefulWidget{

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>{
  final TextEditingController _textController = new TextEditingController();
  Widget _changedTextWidget = Container();
  Future <List<DetailModel>> getAPI_search() async {
    print("loggg1");
    http.Response response;
    List<DetailModel> searchResults =[];
    DetailModel result;
    var data;
    var url =  Uri.parse('http://34.28.16.229:8080/api/v1/places/test');
    final user = await SharedPreferences.getInstance();
    response = await http.get(url,headers: {
      // 임시, 로컬 저장소로 바꿔줘야 함.
      'X-Auth-Token': user.getString('token')??[].toString()
    });


    try{
      data = await json.decode(utf8.decode(response.bodyBytes)) as List;
      // 전 지역 top5의 장소를 리스트에 저장하기 (place_model 형태)

        for(int i = 0 ; i< data.length ; i++){
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
              hashtags1:data[i]["hashtags"][0].toString(),
              hashtags2:data[i]["hashtags"][1].toString());
          searchResults.add(result);
        }

      } catch(e){
      print(e);
      rethrow;
    }
    return searchResults;

  }
  @override
  Widget build(BuildContext context){
    return Container(
        margin: EdgeInsets.fromLTRB(0,10, 0, 0),
        child :
        SizedBox(
            width: 200,
            height: 800,
            child: Container(
                alignment: Alignment.center,
                child : FutureBuilder<List<DetailModel>>(
                  future: getAPI_search(), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot <List<DetailModel>>snapshot) {

                    if (snapshot.hasError) {
                      Text("${snapshot.error}");
                    }else if (snapshot.hasData) {
                      int search = 1;
                      // 주변 지역이 서비스 지역을 벗어난 경우 (전지역만)
                      if(search == 1){
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount : snapshot.data!.length,
                            itemBuilder: (count, index){
                              return InkWell(
                                onTap:() async{
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ScreenDetail(int.parse(snapshot.data![index].placeId)))
                                  );
                                },
                                child: Container(

                                  margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  width: 200,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 4,
                                        blurRadius: 10,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 160,
                                          child: Container(

                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),),                                              color: Colors.black,
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot.data![index].picture as String),
                                                  fit : BoxFit.fill
                                              ),
                                            ),

                                          ),
                                        ),

                                        Container(
                                            margin: EdgeInsets.all(5),
                                            padding:EdgeInsets.all(5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,

                                              children: [
                                                Text(snapshot.data![index].placeName
                                                  ,style: TextStyle(
                                                      color : Color(0xff645F5A),
                                                      letterSpacing: -0.5,
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.w500),),
                                                Text("#${snapshot.data![index].hashtags1}  #${snapshot.data![index].hashtags2} ",
                                                  style: TextStyle(

                                                      color : mainColor,
                                                      letterSpacing: -0.5,
                                                      fontSize: 13.0,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                Text(snapshot.data![index].addressName,
                                                  style: TextStyle(
                                                      color : Colors.grey,
                                                      letterSpacing: -0.5,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w500),),

                                                Container(
                                                  width: 300,
                                                  height: 45,
                                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                  child: Text(snapshot.data![index].info,
                                                    overflow: TextOverflow.clip,
                                                    style: TextStyle(
                                                        color : Colors.grey,
                                                        letterSpacing: -0.5,
                                                        fontSize: 10.0,
                                                        fontWeight: FontWeight.w500),),
                                                ),
                                              ],
                                            )
                                        ),



                                      ]
                                  ),





                                ),
                              );

                            });
                      }
                      // 주변 지역이 서비스 지역인 경우(전지역, 주변)
                    };

                    return CircularProgressIndicator();
                  },
                )
            ))
    );
  }

}



