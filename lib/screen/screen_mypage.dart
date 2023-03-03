import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/widget/market1.dart';
import 'package:largo/widget/market2.dart';
import 'package:largo/widget/market3.dart';
import 'package:largo/widget/market4.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class ScreenMypage extends StatefulWidget{
  _MypageScreenState createState() => _MypageScreenState();
}

class _MypageScreenState extends State<ScreenMypage> {
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
                      MaterialPageRoute(builder: (context) => ScreenHome())
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
                    child : Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: AssetImage('assets/images/example3.png'),
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
                                    '박근영 님',
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
                                                        '11,200',
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
                                                        '활성화',
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

                  )

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
                  child : Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        width: 180,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey
                        ),

                      ),


                    ],
                  )
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
                child : Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: AssetImage('assets/images/example3.png'),
                            fit : BoxFit.fitHeight
                        ),
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: AssetImage('assets/images/example3.png'),
                            fit : BoxFit.fitHeight
                        ),
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: AssetImage('assets/images/example3.png'),
                            fit : BoxFit.fitHeight
                        ),
                      ),

                    ),
                  ],
                )
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





