import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Widget
import 'package:largo/widgets/customAppbar.dart';
import 'package:largo/widgets/customSlider.dart';
import 'package:largo/widgets/customButton.dart';

// Colors
import 'package:largo/color/themeColors.dart';
import 'package:largo/widgets/smallTitle.dart';

class WalkingView extends StatefulWidget {
  @override
  _WalkingView createState() => _WalkingView();
}

class _WalkingView extends State<WalkingView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(top: 40),
        child: Scaffold(
            appBar: CustomAppBar("걸어 보자!"),
    body: SingleChildScrollView(
        child: Container(
            color: backgroundColor,
            height: 700,
            child: Column(
              children: [
                Container(
                    child: Center(
                      child: Text("Maps 예정"),
                    ),
                    color: mainColor,
                    height: 400,
                    margin: const EdgeInsets.all(8.0)),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          ))
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  child: CustomButton("그만 걷기"),
                )
              ],
            )))),
    );
  }
}
