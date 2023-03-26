import 'dart:convert';

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
  //test2
  String result = '';
  List data = [];

  //test1
  List<DetailModel> futureDetailInfo =[];
  bool isLoading = true;
  DetailProvider detailProvider = DetailProvider();

  Future initDetail() async {
    var url = Uri.parse(
        'http://34.64.143.243:8080/api/v1/places/6');
    var response = await http.get(url);
    //futureDetailInfo = await detailProvider.getDetail();
  }

  //test3



  @override
  void initState() {
    super.initState();
    getJSONData();
    initDetail();
    setState(() {
      isLoading = false;
    });

  }
  final List<String> items = [
    '카테고리별',
    '궁',
    '카테고리1',
    '카테고리2',
    '카테고리3',
    '카테고리4',
    '카테고리5',
    '카테고리6',
  ];
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
                      MaterialPageRoute(builder: (context) => ScreenHome())
                  );
                },
                icon : Icon(Icons.arrow_back_sharp),
              ),
              centerTitle: true, // 제목 중앙정렬 허용
              title: RichText(
                  textAlign: TextAlign.center,
                  text : TextSpan(
                      text : "여긴 어때?",
                      style: TextStyle(
                          color : Color(0xff645F5A),
                          letterSpacing: -0.5,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700),
                      children: <TextSpan>[
                        TextSpan(
                          text : '\n #장소 추천    #경험 모음집',
                          style: TextStyle(
                              color : Color(0xffF8A426),
                              letterSpacing: -1.2,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        )
                      ]
                  )

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
                  width :double.infinity,
                  height: 40,
                  child : Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Row(
                              children: const [
                                Icon(
                                  Icons.list,
                                  size: 20,
                                  color: Color(0xff939393),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  child: Text(
                                    '카테고리별',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily : 'notosanskr',
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff939393),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff939393),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 30,
                              width: 130,
                              padding: const EdgeInsets.only(left: 10, right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Color(0xff939393),
                                ),
                              ),
                              elevation: 0,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_outlined,
                              ),
                              iconSize: 20,
                              iconEnabledColor: Color(0xff939393),
                              iconDisabledColor: Colors.red,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 130,
                              padding: null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 8,
                              offset: const Offset(0, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility: MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Color(0xff939393),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  child: Text(
                                    '추천순',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily : 'notosanskr',
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff939393),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff939393),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 30,
                              width: 100,
                              padding: const EdgeInsets.only(left: 10, right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Color(0xff939393),
                                ),
                              ),
                              elevation: 0,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_outlined,
                              ),
                              iconSize: 20,
                              iconEnabledColor: Color(0xff939393),
                              iconDisabledColor: Colors.red,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 100,
                              padding: null,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 8,
                              offset: const Offset(0, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility: MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ),
                    ],

                  )),
              Expanded(
                child:
                Container(
                  margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                  child: Center(
                    child: data.length == 0
                        ? Text(
                      "데이터가 없습니다",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )
                        : ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            child: Column(
                              children: [
                                Text(data[index]['place_id'].toString()),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: data.length,
                    ),



                  ),
                ),
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





