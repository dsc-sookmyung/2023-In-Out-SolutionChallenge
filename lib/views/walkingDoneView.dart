import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// 라우터
import 'package:largo/router/router.dart';
import 'package:largo/service/APIService.dart';

// Widget
import 'package:largo/widgets/customAppbar.dart';
import 'package:largo/widgets/customSlider.dart';
import 'package:largo/widgets/customButton.dart';

// Colors
import 'package:largo/color/themeColors.dart';
import 'package:largo/widgets/smallTitle.dart';

// API
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screen/screen_main.dart';

class WalkingDoneViewArguments {
  final Uint8List? map_image;
  final String total_time;
  final double total_distance;
  final List<LatLng> point_list;
  final List<Uint8List>? place_img;

  WalkingDoneViewArguments(this.map_image, this.total_time, this.total_distance, this.point_list, this.place_img);
}

class WalkingDoneView extends StatefulWidget {

  @override
  _WalkingDoneView createState() => _WalkingDoneView();
}

class _WalkingDoneView extends State<WalkingDoneView> {

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as WalkingDoneViewArguments;
    String mapImageUrl = "";
    List<String> userImageUrl = [];

    print("Final Data : ${args.map_image}");

    void uploadImage() {
      APIService().uploadImage("test_map.jpg", args.map_image!).then((value) => {
        mapImageUrl = value
      });

      for(int i = 0; i < args.place_img!.length; i++) {
        APIService().uploadImage("test_map.jpg", args.place_img![i]).then((value) => {
          mapImageUrl = value
        });
      }

      print("upload done");
    }

    return SafeArea(
        minimum: EdgeInsets.only(top: 40),
        child: Scaffold(
          appBar: CustomAppBar("걷기 완료!"),
          body: SingleChildScrollView(
              child: Container(
                  color: backgroundColor,
                  height: 700,
                  child: Column(
                    children: [
                      Container(
                        child: Image.memory(args.map_image!),
                          height: 250,
                          margin: const EdgeInsets.all(8.0)),
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SmallTitle("걸은 시간"),
                                          Text(
                                            args!.total_time,
                                            style: TextStyle(
                                                color: Colors.black,
                                                letterSpacing: 1,
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SmallTitle("총거리"),
                                          Row(
                                            children: [
                                              Text(
                                                args!.total_distance.toStringAsFixed(3),
                                                style: TextStyle(
                                                  color: highlightColor2,
                                                  letterSpacing: 0.5,
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Km",
                                                style: TextStyle(
                                                    color: greyScale2,
                                                    fontSize: 14,
                                                    height: 2.7),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SmallTitle("사진 기록"),
                                      Row(
                                        children: [
                                          Text(
                                            args!.place_img!.length.toString().padLeft(2, "0"),
                                            style: TextStyle(
                                              color: highlightColor,
                                              letterSpacing: 1,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "개",
                                            style: TextStyle(
                                                color: greyScale2,
                                                fontSize: 14,
                                                height: 2.7),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          )),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: args.place_img!.length,
                            itemBuilder: (BuildContext context, int index){
                          return Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: MemoryImage(args.place_img![index]),
                                fit : BoxFit.fitHeight
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.23),
                                  spreadRadius: 3,
                                  blurRadius:
                                  9, // changes position of shadow
                                ),
                              ],
                            ),
                          );
                        })
                      ),
                      Container(
                        width: 350,
                        child: CustomButton(
                          GestureDetector(
                            child: Text("공유 하기",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: greyScale4),),
                            onTap: () {
                              print("공유 하기");
                              uploadImage();
                              Future.delayed(Duration(seconds: 2), () {
                                APIService().uploadRunData(args.point_list, args.total_time, args.total_distance, mapImageUrl, userImageUrl);
                                Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                              });
                            }
                          ),
                        ),
                      )
                    ],
                  ))),
        ));
  }
}
