import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:largo/screen/screen_mypage.dart';
import 'package:largo/screen/screen_search.dart';
import 'package:largo/widget/bottom_bar.dart';
import 'package:largo/widget/market1.dart';
import 'package:largo/widget/market2.dart';
import 'package:largo/widget/market3.dart';
import 'package:largo/widget/market4.dart';

class ScreenHome extends StatefulWidget{
  _HomeScreenState createState() => _HomeScreenState();
}
int _currentIndex=0;
List cardList=[
  Market1(),
  Market2(),
  Market3(),
  Market4()

];
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}


class _HomeScreenState extends State<ScreenHome> {
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
              actions: <Widget>[
                IconButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScreenMypage())
                    );
                  },
                  color : Color(0xff645F5A),
                  icon : Icon(Icons.account_circle),
                )
              ],
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
          margin: EdgeInsets.fromLTRB(23, 10, 23, 23),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width :double.infinity,
                      height: 150,
                      color : Colors.blueGrey,
                      margin : EdgeInsets.fromLTRB(0, 0, 0, 26),
                      child : Text('배너',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center)
                  ),

                  Text("용산구, 관광 경험 TOP5",
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

                  SizedBox(
                    height: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("상세정보"),
                        Text("상세정보"),
                      ],
                    ),
                  ),

// 2번째
// 제목
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
                    items: cardList.map((card){
                      return Builder(
                          builder:(BuildContext context){
                            return Container(
                              margin : EdgeInsets.fromLTRB(0, 12, 0, 14),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,

                              child: Card(
                                //color: Colors.blueAccent,
                                child: card,
                              ),
                            );
                          }
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(cardList, (index, url) {
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
              ),
            ],
          )
        ),
      ),
    );
  }

}





