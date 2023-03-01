import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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

class WalkingDoneView extends StatefulWidget {
  @override
  _WalkingDoneView createState() => _WalkingDoneView();
}

class _WalkingDoneView extends State<WalkingDoneView> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.5465, 126.9647),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
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
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                          color: mainColor,
                          height: 250,
                          margin: const EdgeInsets.all(8.0)),
                      Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
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
                                            "00:00:00",
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
                                                "1.00",
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
                                            "00",
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
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index){
                          return Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://googleflutter.com/sample_image.jpg'),
                                  fit: BoxFit.fill),
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
                        child: CustomButton("공유 하기"),
                      )
                    ],
                  ))),
        ));
  }
}
