import 'dart:convert';
import 'package:largo/screen/screen_main.dart';
import 'package:largo/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:largo/main.dart';
import 'package:largo/models/detail_model.dart';
import 'package:largo/providers/detail_provider.dart';
import 'package:largo/screen/screen_detail.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/widget/market1.dart';
import 'package:largo/widget/market2.dart';
import 'package:largo/widget/market3.dart';
import 'package:largo/widget/market4.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
//상세정보
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

var response;

class ScreenSearch extends StatefulWidget{
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ScreenSearch> {




  @override
  void initState() {
    super.initState();
    getJSONData();

  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily : 'notosanskr',
      ),
      home: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(74),
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
              centerTitle: true, // 제목 중앙정렬 허용
              title: Container(
                child:Container(
                  margin: EdgeInsets.all(0),
                  child: SearchBar(),
                ),
                ),

              elevation: 0, // 그림자 없애기
              shape : RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
              )

          ),
        ),


        body:
        Container(
          width :double.infinity,
          margin: EdgeInsets.fromLTRB(23, 0, 23, 23),
          child:   Column(
            children :[
              Container(
                margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                child : SearchBar()
              ),



              ]
          ),
        )
      ),
    );
  }
  Future<String> getJSONData() async {
    var url = Uri.parse(
        'http://34.64.143.243:8080/api/v1/places/6');
    var response = await http
        .get(url);
    var dataConvertedToJSON = json.decode(utf8.decode(response.bodyBytes));
    int placeid = dataConvertedToJSON["place_id"];
    String placeName = dataConvertedToJSON["place_name"];
    print(placeid);
    print(placeName);

    print(utf8.decode(response.bodyBytes));

    return 'hello';

  }

}

class InformBox extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  final BorderRadius _baseBorderRadius = BorderRadius.circular(8);
  InformBox({@required this.onTap, @required this.child});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: _baseBorderRadius),
      child: InkWell(

        borderRadius: _baseBorderRadius,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: _baseBorderRadius,
            color: Colors.transparent,
          ),
          child: child,
        ),
      ),
    );
  }
}





