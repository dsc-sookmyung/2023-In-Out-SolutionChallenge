import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:largo/models/course_model.dart';
import 'package:largo/models/user_model.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/screen/screen_main.dart';
import 'package:largo/widget/market1.dart';
import 'package:largo/widget/market2.dart';
import 'package:largo/widget/market3.dart';
import 'package:largo/widget/market4.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ScreenMypage extends StatefulWidget{
  _MypageScreenState createState() => _MypageScreenState();
}

class _MypageScreenState extends State<ScreenMypage> {
  //회원 정보 불러오기
  Future <UserModel> getAPI_user() async {
    var data;
    UserModel userInfo;
    http.Response response;
    final user = await SharedPreferences.getInstance();
    response = await http.get(Uri.parse('http://34.64.143.243:8080/api/v1/user'),headers: {
      // 임시, 로컬 저장소로 바꿔줘야 함.
      'X-Auth-Token': user.getString('token')??[].toString()
    });

    try{

      data = await json.decode(utf8.decode(response.bodyBytes));
      userInfo = await UserModel(
          user_name: data["user_name"].toString(),
          picture: data["picture"].toString(),
          reward: data["reward"].toString(),
          agreement: data["agreement"], // agreement는 bool


      );
      print('log1');
    } catch(e){
      print(e);
      rethrow;
    }
    return userInfo;

  }

  // 회원의 코스기록 불러오기
  Future <List <dynamic>> getAPI_record_course() async {
    http.Response response;
    List<dynamic> courseList =[];
    CourseModel termCourseModel;
    List data;
    var url =  Uri.parse('http://34.64.143.243:8080/api/v1/courses');
    print('log3');
    final user = await SharedPreferences.getInstance();
    response = await http.get(url,headers: {
      // 임시, 로컬 저장소로 바꿔줘야 함.
      'X-Auth-Token': user.getString('token')??[].toString()
    });
    print(response.body.toString());

    try{
      data = await json.decode(utf8.decode(response.bodyBytes)) as List;
      for(int i = 0 ; i< data.length ; i++){
        print(data.runtimeType);
        print(data[i].runtimeType);
        courseList.add(data[i]);

      }

      print(courseList);
      print(courseList.runtimeType);
    } catch(e){
      print(e);
      rethrow;
    }
    return courseList;

  }

  // 회원의 사진 기록 불러오기
  Future <List <dynamic>> getAPI_record_picture() async {
    http.Response response;
    var data;
    var url =  Uri.parse('http://34.64.143.243:8080/api/v1/courses/pictures');
    final user = await SharedPreferences.getInstance();
    print('log2');
    response = await http.get(url,headers: {
      'X-Auth-Token': user.getString('token')??[].toString()
    });
    print(response.body.toString());

    try{
      data = await json.decode(utf8.decode(response.bodyBytes)) as List;
      print(data.toString());

    } catch(e){

      print(e);
      rethrow;
    }
    return data;

  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily : 'notosanskr',
      ),
      home: Scaffold(
        backgroundColor: Color(0xffF5F5F5),

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
              backgroundColor: Color(0xffF5F5F5),
              leading:  IconButton(
                color : Color(0xff645F5A),
                onPressed:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenMain())
                  );
                },
                icon : Icon(Icons.arrow_back_sharp),
              ),
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                onPressed: (){

                },
                color : Color(0xff645F5A),
                icon : Icon(Icons.more_horiz),
              )
            ],
            title: Text("마이 페이지",
                style: TextStyle(
                    color : Color(0xff645F5A),
                    letterSpacing: -1.2,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center
            ),
              centerTitle: true, // 제목 중앙정렬 허용
              elevation: 0, // 그림자 없애기

          ),
        ),


        body: Container(
          width :double.infinity,
          margin: EdgeInsets.fromLTRB(23, 0, 23, 23),
          child:   ListView(
            children :[
                Container(
                margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                width: double.infinity,
                    child : FutureBuilder<UserModel>(
                      future: getAPI_user(), // a previously-obtained Future<String> or null
                      builder: (BuildContext context, AsyncSnapshot <UserModel>snapshot) {

                        if (snapshot.hasError) {
                          Text("${snapshot.error}");
                        }else if (snapshot.hasData) {
                          return Row(
                            children: [
                              // 회원 얼굴
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      image:NetworkImage(snapshot.data!.picture as String),
                                      fit : BoxFit.fitHeight
                                  ),
                                ),

                              ),
                              Container(
                                  width: 240,
                                  height: 100,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                                  child : Column(
                                      children: [
                                        Container(
                                            width: 240,
                                            height: 30,
                                            child :Text(
                                                snapshot.data!.user_name +'님',
                                                style: TextStyle(
                                                    color : Color(0xff645F5A),
                                                    letterSpacing: -0.5,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.start

                                            )
                                        ),
                                        Container(
                                            width: 240,
                                            height: 65,
                                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                            child : Row(
                                                children: [
                                                  Container(
                                                      width: 110,
                                                      height: 65,
                                                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                      child : Column(
                                                          children: [
                                                            Container(
                                                              width: 110,
                                                              height: 30,
                                                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),

                                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                              child :Text(
                                                                  '누적 포인트',
                                                                  style: TextStyle(
                                                                      color : Colors.white,
                                                                      letterSpacing: -0.5,
                                                                      fontSize: 12.0,
                                                                      fontWeight: FontWeight.w400),
                                                                  textAlign: TextAlign.center

                                                              ),
                                                              decoration: BoxDecoration(
                                                                color : Colors.grey,
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 110,
                                                              height: 30,
                                                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),

                                                              child :Text(
                                                                  snapshot.data!.reward,
                                                                  style: TextStyle(
                                                                      color : Color(0xff645F5A),
                                                                      letterSpacing: -0.5,
                                                                      fontSize: 12.0,
                                                                      fontWeight: FontWeight.w400),
                                                                  textAlign: TextAlign.center

                                                              ),
                                                            ),

                                                          ])
                                                  ),
                                                  Container(
                                                      width: 110,
                                                      height: 65,
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      child : Column(
                                                          children: [
                                                            Container(
                                                              width: 110,
                                                              height: 30,
                                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),

                                                              child :Text(
                                                                  '사진 공유',
                                                                  style: TextStyle(
                                                                      color : Colors.white,
                                                                      letterSpacing: -0.5,
                                                                      fontSize: 12.0,
                                                                      fontWeight: FontWeight.w400),
                                                                  textAlign: TextAlign.center

                                                              ),
                                                              decoration: BoxDecoration(
                                                                color : Colors.grey,
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 110,
                                                              height: 30,
                                                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),

                                                              child :Text(
                                                                  agreeToText(snapshot.data!.agreement.toString()),
                                                                  style: TextStyle(
                                                                      color : Color(0xff645F5A),
                                                                      letterSpacing: -0.5,
                                                                      fontSize: 12.0,
                                                                      fontWeight: FontWeight.w400),
                                                                  textAlign: TextAlign.center

                                                              ),
                                                            ),
                                                          ])
                                                  ),

                                                ])
                                        ),


                                      ])
                              )
                            ],

                          );
                        };

                        return CircularProgressIndicator();
                      },
                    ),


              ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  width: double.infinity,
                  child: Text(
                    '코스기록',
                    style: TextStyle(
                        color : Color(0xff645F5A),
                        letterSpacing: -0.5,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),),
                  ),
              Container(
                  width: double.infinity,
                  child : FutureBuilder<List<dynamic>>(
                    future: getAPI_record_course(), // a previously-obtained Future<String> or null
                    builder: (BuildContext context, AsyncSnapshot <List<dynamic>>snapshot) {
                      if (snapshot.hasError) {
                        Text("${snapshot.error}");
                      }else if (snapshot.hasData) {
                        return  SizedBox(
                          height: 250,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount : snapshot.data!.length,
                              itemBuilder: (count, index){
                                return Container(
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
                                                image: NetworkImage(snapshot.data![index]["picture"].toString()),
                                                fit : BoxFit.fitWidth
                                            ),
                                          ),

                                        ),

                                        Container(
                                          margin: EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                          Text(snapshot.data![index]["created_date"].toString()
                                          ,style: TextStyle(
                                            color : Color(0xff645F5A),
                                            letterSpacing: -0.5,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w500),),
                                
                                            Text(snapshot.data![index]["total_time"].toString(),
                                            style: TextStyle(
                                            color : Colors.grey,
                                            letterSpacing: -0.5,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500),),
                                            Text(snapshot.data![index]["total_dist"].toString(),
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

                                );

                              }),
                        );

                      };

                      return CircularProgressIndicator();
                    },
                  ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                width: double.infinity,
                child: Text(
                  '사진기록',
                  style: TextStyle(
                      color : Color(0xff645F5A),
                      letterSpacing: -0.5,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),),
              ),

              Container(
                width: double.infinity,
                child : FutureBuilder<List<dynamic>>(
                  future: getAPI_record_picture(), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot <List<dynamic>>snapshot) {
                    if (snapshot.hasError) {
                      Text("${snapshot.error}");
                    }else if (snapshot.hasData) {
                      return  SizedBox(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,

                            itemCount : snapshot.data!.length,
                            itemBuilder: (count, index){
                              return Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),

                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 4,
                                      blurRadius: 10,
                                      offset: Offset(0, 3), // ch/ changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot.data![index] as String),
                                      fit : BoxFit.fitHeight
                                  ),
                                ),
                              );

                            }),
                      );

                    };

                    return CircularProgressIndicator();
                  },
                ),


              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                width: double.infinity,
                child: Text(
                  '로그 아웃',
                  style: TextStyle(
                      color : Color(0xff645F5A),
                      letterSpacing: -0.5,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),),
              ),









              ]

          ),
        )
      ),
    );
  }
  String agreeToText(String  boolValue){
    if(boolValue == true){
      return "활성화";

    }
    else{
      return "비활성화";

    }
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





