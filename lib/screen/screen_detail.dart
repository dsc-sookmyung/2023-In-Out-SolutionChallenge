import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/widget/market1.dart';
import 'package:largo/widget/market2.dart';
import 'package:largo/widget/market3.dart';
import 'package:largo/widget/market4.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class ScreenDetail extends StatefulWidget{
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<ScreenDetail> {
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
                width : double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  //color : Colors.red,
                  borderRadius: BorderRadius.circular(13),
                  image: DecorationImage(
                      image: AssetImage('assets/images/example3.png'),
                      fit : BoxFit.fitWidth
                  ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 10),
                  width: double.infinity,
                  child: Text(
                    '경복궁',
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
                          '#궁궐',
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
                          '#트렌디한',
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
                      '경복궁은 조선 왕조 제일의 법궁입니다. 북으로 북악산을 기대어 자리 잡았고 정문인 광화문 앞으로는 넓은 육조거리(지금의 세종로)가 펼쳐져, 왕도인 한양(서울) 도시 계획의 중심이기도 합니다.',
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
                  child: Text('위치정보, 구글맵 들어가는 자리입니다.'),
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





