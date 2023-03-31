import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:largo/models/place_model.dart';
import 'package:largo/providers/detail_provider.dart';
import 'package:largo/screen/screen_detail.dart';
import 'package:largo/screen/screen_search.dart';
import 'package:largo/widget/market1.dart';
import 'package:largo/widget/market2.dart';
import 'package:largo/widget/market3.dart';
import 'package:largo/widget/market4.dart';

//상세정보
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/market_model.dart';

class ScreenHome extends StatefulWidget{
  _HomeScreenState createState() => _HomeScreenState();
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}


class _HomeScreenState extends State<ScreenHome> {
  String result = '';
  int termIndex  = 0;
  double _long =0;
  double _lat =0;


  List data = [];
  int _currentIndex=0;
  int _currentIndex2=0;

  List<String> Banners = [
    'assets/images/Banner2.png',
    'assets/images/Banner3.png',
    'assets/images/Banner4.png'];
  List<dynamic> Markets =[];
  List cardList=[
    Market1(),
    Market2(),
    Market3(),
    Market4()
  ];
  late Future futurePlace;
  late Future futureMarket;

  String nullPic (String uri){
    if (uri == "null"){
      return "https://storage.googleapis.com/largo-storage/%E1%84%87%E1%85%A9%E1%86%BC%E1%84%92%E1%85%AA%E1%86%BC%E1%84%80%E1%85%A1%E1%86%A8.jpeg";
    }else{
      return uri;
    }
  }

  Future <void> getPostion() async{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _lat = position.latitude;
    _long = position.longitude;
    logger.d('lat;;;;;;;;;;;;;;;;;;;', _lat);
    logger.d('long;;;;;;;;;;;;;;;;;;', _long);

  }

  Future <List<dynamic>> getAPI_places_top() async {
    http.Response response;
    List<dynamic> places =[];
    List<PlaceModel> placeTopList =[];
    List<PlaceModel> placeNearList =[];

    PlaceModel termPlaceModel;
    var data;
    var url =  Uri.parse('http://34.28.16.229:8080/api/v1/places/top?latitude=${_lat}&longitude=${_long}');
    //print('lat :${_lat} long:${_long}');
    final user = await SharedPreferences.getInstance();
    response = await http.get(url,headers: {
      // 임시, 로컬 저장소로 바꿔줘야 함.
      'X-Auth-Token': user.getString('token')??[].toString()
    });

    try{
      data = await json.decode(utf8.decode(response.bodyBytes));
      // 전 지역 top5의 장소를 리스트에 저장하기 (place_model 형태)

      for(int i = 0 ; i< data["total"].length ; i++){
        termPlaceModel = PlaceModel(
            place_id: data["total"][i]["place_id"],
            place_name: data["total"][i]["place_name"].toString(),
            picture: data["total"][i]["picture"].toString(),
            hashtags: data["total"][i]["hashtags"],
            address: data["total"][i]["address"]);
        placeTopList.add(termPlaceModel);
      }
      if(data["near"] == null){
        // near관련 ui 안 보이게 처리할 것.
        placeNearList = [];
      }else{
        for(int i = 0 ; i< 5 ; i++){
          termPlaceModel = PlaceModel(
              place_id: data["near"][i]["place_id"],
              place_name: data["near"][i]["place_name"].toString(),
              picture: data["near"][i]["picture"].toString(),
              hashtags: data["near"][i]["hashtags"],
              address: data["near"][i]["address"]);
          placeNearList.add(termPlaceModel);
        }
      }
      places.add(placeTopList);
      places.add(placeNearList);
    } catch(e){
      print(e);
      rethrow;
    }
    return places;

  }

  Future <List<dynamic>> getAPI_market() async {
    http.Response response;
    List<dynamic> MarketList = [];
    MarketModel termMarketModel;
    var data;
    var url = Uri.parse('http://34.28.16.229:8080/api/v1/markets');
    final user = await SharedPreferences.getInstance();
    response = await http.get(url, headers: {
      // 임시, 로컬 저장소로 바꿔줘야 함.
      'X-Auth-Token': user.getString('token') ?? [].toString()
    });
    try {
      data = await json.decode(utf8.decode(response.bodyBytes)) as List;
      // 전 지역 top5의 장소를 리스트에 저장하기 (place_model 형태)
      for (int i = 0; i < data.length; i++) {
        termMarketModel = MarketModel(
            market_id: data[i]["market_id"],
            market_name: data[i]["market_name"].toString(),
            address_name: data[i]["address_name"].toString(),
            longitude: data[i]["longitude"],
            latitude: data[i]["latitude"],
            picture: data[i]["picture"].toString());
        MarketList.add(termMarketModel);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
    Markets = MarketList;

    return MarketList;
  }
  @override
  void initState() {
    super.initState();
    getPostion().then((value) => futurePlace = getAPI_places_top());
    futureMarket = getAPI_market();
  }

  @override
  Widget build(BuildContext context) {
    final DetailProvider viewmodel = DetailProvider();
    return MaterialApp(
      theme: ThemeData(
        fontFamily : 'notosanskr',
      ),
      home: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child:AppBar(
              backgroundColor: Color(0xffFFDEAC),
              elevation: 0,
              leading:  IconButton(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                color : Color(0xff645F5A),
                onPressed:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenSearch())
                  );
                },
                icon : Icon(Icons.search),
              ),
              title: Text("여행할 지역을 검색해보세요!",
                  style: TextStyle(
                      color : Color(0xff645F5A),
                      letterSpacing: -1.2,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center
              ),
              shape : RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
              )
          ),
        ),

        body: Container(
          width :double.infinity,
          margin: EdgeInsets.fromLTRB(23, 5, 23, 23),
          child:ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
// 배너
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 250.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      viewportFraction: 1, // 슬라이더 안 보이게 함.
                      onPageChanged: (index2, reason) {
                        setState(() {
                          _currentIndex2 = index2;

                          //_currentIndex = index-1;

                        });
                      },
                    ),
                    items: Banners.map((card){
                      return Builder(
                          builder:(BuildContext context){
                            return Container(
                              margin : EdgeInsets.fromLTRB(0, 5, 0, 5),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                color: Colors.black12,
                                child: Container(
                                  width : 329,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(Banners[_currentIndex2]),
                                        fit : BoxFit.fitWidth
                                    ),
                                  ),


                                ),
                              ),
                            );
                          }
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(Banners, (index2, url) {
                      return Container(
                        width: 8.0,
                        height: 12.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex2 == index2 ? Color(0xff757575) : Colors.grey.shade400,
                        ),
                      );
                    }),
                  ),
//전지역
                  Container(
                      child: FutureBuilder<List<dynamic>>(
                        future: getAPI_places_top(), // a previously-obtained Future<String> or null
                        builder: (BuildContext context, AsyncSnapshot <List<dynamic>>snapshot) {
                          if (snapshot.hasError) {
                            Text("${snapshot.error}");
                          }else if (snapshot.hasData) {
                            // 주변 지역이 서비스 지역을 벗어난 경우 (전지역만)
                            if(snapshot.data![1].length != 0){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("전 지역, 관광 경험 TOP5",
                                      style: TextStyle(
                                          color : Color(0xff645F5A),
                                          letterSpacing:-0.5,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center),
                                  Text("#색다른 #좋아할만한"
                                      ,style: TextStyle(
                                          color : Color(0xffF8A426),
                                          letterSpacing:-0.5,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: SizedBox(
                                      height: 250,

                                      child:
                                      ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount : snapshot.data![0].length,
                                          itemBuilder: (count, index){
                                            return InkWell(
                                              onTap:() async{
                                                final result = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => ScreenDetail(snapshot.data![0][index].place_id))
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                width: 230,
                                                height: 250,
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
                                                      Container(

                                                        width: 230,
                                                        height: 160,
                                                        decoration: BoxDecoration(

                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: NetworkImage(nullPic(snapshot.data![0][index].picture as String)),
                                                              fit : BoxFit.fitWidth
                                                          ),
                                                        ),

                                                      ),

                                                      Container(
                                                          margin: EdgeInsets.all(5),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,

                                                            children: [
                                                              Text(snapshot.data![0][index].place_name
                                                                ,style: TextStyle(
                                                                    color : Color(0xff645F5A),
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 20.0,
                                                                    fontWeight: FontWeight.w500),),

                                                              Text(snapshot.data![0][index].address,
                                                                style: TextStyle(
                                                                    color : Colors.grey,
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.w500),),
                                                              Text("#${snapshot.data![0][index].hashtags[0]}  #${snapshot.data![0][index].hashtags[1]}  #${snapshot.data![0][index].hashtags[2]}",
                                                                style: TextStyle(
                                                                    color : Colors.grey,
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.w500),),
                                                            ],
                                                          )
                                                      ),



                                                    ]
                                                ),





                                              ),
                                            );

                                          }),

                                    ),
                                  ),
                                ],
                              );
                            }
                            // 주변 지역이 서비스 지역인 경우(전지역, 주변)
                            else{
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("전 지역, 관광 경험 TOP5",
                                      style: TextStyle(
                                          color : Color(0xff645F5A),
                                          letterSpacing:-0.5,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center),
                                  Text("#색다른 #좋아할만한"
                                      ,style: TextStyle(
                                          color : Color(0xffF8A426),
                                          letterSpacing:-0.5,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: SizedBox(
                                      height: 250,

                                      child:
                                      ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount : snapshot.data![0].length,
                                          itemBuilder: (count, index){
                                            return InkWell(
                                              onTap:() async{
                                                final result = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => ScreenDetail(snapshot.data![0][index].place_id))
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                width: 230,
                                                height: 250,
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
                                                      Container(

                                                        width: 230,
                                                        height: 160,
                                                        decoration: BoxDecoration(

                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: NetworkImage(nullPic(snapshot.data![0][index].picture as String)),
                                                              fit : BoxFit.fitWidth
                                                          ),
                                                        ),

                                                      ),

                                                      Container(
                                                          margin: EdgeInsets.all(5),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,

                                                            children: [
                                                              Text(snapshot.data![0][index].place_name
                                                                ,style: TextStyle(
                                                                    color : Color(0xff645F5A),
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 20.0,
                                                                    fontWeight: FontWeight.w500),),

                                                              Text(snapshot.data![0][index].address,
                                                                style: TextStyle(
                                                                    color : Colors.grey,
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.w500),),
                                                              Text("#${snapshot.data![0][index].hashtags[0]}  #${snapshot.data![0][index].hashtags[1]}  #${snapshot.data![0][index].hashtags[2]}",
                                                                style: TextStyle(
                                                                    color : Colors.grey,
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.w500),),
                                                            ],
                                                          )
                                                      ),



                                                    ]
                                                ),





                                              ),
                                            );

                                          }),

                                    ),
                                  ),
                                  // 근처
                                  Text(" 근처, 관광 경험 TOP5",
                                      style: TextStyle(
                                          color : Color(0xff645F5A),
                                          letterSpacing:-0.5,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center),
                                  Text("#색다른 #좋아할만한"
                                      ,style: TextStyle(
                                          color : Color(0xffF8A426),
                                          letterSpacing:-0.5,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 30),
                                    child: SizedBox(
                                      height: 250,

                                      child:
                                      ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount : snapshot.data![0].length,
                                          itemBuilder: (count, index){
                                            return InkWell(
                                              onTap:() async{
                                                final result = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => ScreenDetail(snapshot.data![1][index].place_id))
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                width: 230,
                                                height: 250,
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
                                                      Container(

                                                        width: 230,
                                                        height: 160,
                                                        decoration: BoxDecoration(

                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          image: DecorationImage(
                                                              image: NetworkImage(nullPic(snapshot.data![1][index].picture as String)),
                                                              fit : BoxFit.fitWidth
                                                          ),
                                                        ),

                                                      ),

                                                      Container(
                                                          margin: EdgeInsets.all(5),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,

                                                            children: [
                                                              Text(snapshot.data![1][index].place_name
                                                                ,style: TextStyle(
                                                                    color : Color(0xff645F5A),
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 20.0,
                                                                    fontWeight: FontWeight.w500),),

                                                              Text(snapshot.data![1][index].address,
                                                                style: TextStyle(
                                                                    color : Colors.grey,
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.w500),),
                                                              Text("#${snapshot.data![1][index].hashtags[0]}  #${snapshot.data![1][index].hashtags[1]}  #${snapshot.data![1][index].hashtags[2]}",
                                                                style: TextStyle(
                                                                    color : Colors.grey,
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.w500),),
                                                            ],
                                                          )
                                                      ),



                                                    ]
                                                ),





                                              ),
                                            );

                                          }),

                                    ),
                                  ),
                                ],
                              );
                            }
                          };

                          return CircularProgressIndicator();
                        },
                      )
                  ),



                  Text("우리 동네 전통 시장",
                      style: TextStyle(
                          color : Color(0xff645F5A),
                          letterSpacing: -0.5,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center),

                  Text("#핫플보다 힙한 #뻔하지않은",
                      style: TextStyle(
                          color : Color(0xffF8A426),
                          letterSpacing: -0.5,

                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center),

// 전통시장 컨텐츠

                  Container(
                      child: FutureBuilder<List<dynamic>>(
                        future: getAPI_market(), // a previously-obtained Future<String> or null
                        builder: (BuildContext context, AsyncSnapshot <List<dynamic>>snapshot) {
                          if (snapshot.hasError) {
                            Text("${snapshot.error}");
                          }else if (snapshot.hasData) {
                            return Column(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 250.0,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    pauseAutoPlayOnTouch: true,
                                    viewportFraction: 1, // 슬라이더 안 보이게 함.
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  ),
                                  items: Markets.map((card){
                                    return Builder(
                                        builder:(BuildContext context){
                                          return Container(
                                            margin : EdgeInsets.fromLTRB(0, 12, 0, 14),
                                            height: MediaQuery.of(context).size.height,
                                            width: MediaQuery.of(context).size.width,

                                            child: Container(
                                                width : 329,
                                                height: 250,
                                                decoration: BoxDecoration(
                                                  //color : Colors.red,
                                                  borderRadius: BorderRadius.circular(13),
                                                  image: DecorationImage(
                                                      image: NetworkImage(nullPic(Markets[_currentIndex].picture.toString())),
                                                      fit : BoxFit.fitWidth
                                                  ),

                                                ),
                                                child: Stack(
                                                  children: [
                                                    Opacity(opacity: 0.3,
                                                      child: Container(
                                                        width : double.infinity,
                                                        height: 250,
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius: BorderRadius.circular(13)
                                                        ),

                                                      ),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets.all(16),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(Markets[_currentIndex].market_name.toString(),
                                                                style: TextStyle(
                                                                    color : Colors.white,
                                                                    letterSpacing:-0.5,
                                                                    fontSize: 20.0,
                                                                    fontWeight: FontWeight.w500),
                                                                textAlign: TextAlign.start),
                                                            // Text('주민 추천 ${_currentIndex +1}위',
                                                            //     style: TextStyle(
                                                            //         color : Colors.white,
                                                            //         letterSpacing: -0.5,
                                                            //         fontSize: 12.0,
                                                            //         fontWeight: FontWeight.w400),
                                                            //     textAlign: TextAlign.start),
                                                            Text(Markets[_currentIndex].address_name.toString(),
                                                                style: TextStyle(
                                                                    color : Colors.white,
                                                                    letterSpacing: -0.5,
                                                                    fontSize: 12.0,
                                                                    fontWeight: FontWeight.w400),
                                                                textAlign: TextAlign.start),
                                                          ],


                                                        )
                                                    )
                                                  ],
                                                )

                                            ),
                                          );
                                        }
                                    );
                                  }).toList(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: map<Widget>(Markets, (index, url) {
                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentIndex == index ? Color(0xff757575) : Colors.grey.shade400,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            );


                          }
                          return CircularProgressIndicator();
                        },
                      )

                  ),
                ],
              ),
            ],
          ),


        ),
      ),
    );

  }



}




