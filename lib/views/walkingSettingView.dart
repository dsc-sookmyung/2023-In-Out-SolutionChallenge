
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Widget
import 'package:largo/widgets/customAppbar.dart';
import 'package:largo/widgets/customSlider.dart';
import 'package:largo/widgets/customButton.dart';
import 'package:largo/widgets/smallTitle.dart';

// Colors
import 'package:largo/color/themeColors.dart';

class WalkingSettingView extends StatefulWidget {
  @override
  _WalkingSettingView createState() => _WalkingSettingView();
}

class _WalkingSettingView extends State<WalkingSettingView> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    double _height = MediaQuery.of(context).size.height - (statusBarHeight * 2);
    double _width = MediaQuery.of(context).size.width;
    double _cardHeight = _height * 0.72;
    double _cardWidth = _width * 0.52;
    double _innerImageHeight = _cardHeight * 0.83;
    double _innerImageWidth = _cardWidth * 0.95;

    // TODO: implement build
    return SafeArea(
        minimum: EdgeInsets.only(top: 40),
        child: Scaffold(
            appBar: CustomAppBar("걸어 볼까?"),
          body:SingleChildScrollView(
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
                        width: 350,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                            ),
                            Container(
                              width: 350,
                              child: Text(
                                "장소 검색 거리 반경",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: greyScale5,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            CustomSlider(),
                            Container(
                              width: 325,
                              child: Row(
                                children: [
                                  Text(
                                    "10m",
                                    style: TextStyle(color: greyScale2),
                                  ),
                                  Text("10Km",
                                      style: TextStyle(color: greyScale2))
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                            ),
                            CustomButton("걷기 시작")
                          ],
                        ),
                      )
                    ],
                  ))))
        );
  }
}
