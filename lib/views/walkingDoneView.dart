import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Widget
import 'package:largo/widgets/customAppbar.dart';
import 'package:largo/widgets/customSlider.dart';
import 'package:largo/widgets/customButton.dart';

// Colors
import 'package:largo/color/themeColors.dart';
import 'package:largo/widgets/smallTitle.dart';

class WalkingDoneView extends StatefulWidget {
  @override
  _WalkingDoneView createState() => _WalkingDoneView();
}

class _WalkingDoneView extends State<WalkingDoneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar("걷기 완료!"),
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
                        height: 250,
                        margin: const EdgeInsets.all(8.0)),
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 50),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                letterSpacing: 1,
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
                                )),
                          ],
                        )),
                    SizedBox(
                      height: 120, // constrain height
                      width: 370,
                      child: GridView.builder(
                          itemCount: 3, //item 개수
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                            mainAxisSpacing: 10, //수평 Padding
                            crossAxisSpacing: 10, //수직 Padding
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: 30,
                              height: 30,
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
                                    blurRadius: 9, // changes position of shadow
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      width: 350,
                      child: CustomButton("공유 하기"),
                    )
                  ],
                ))));
  }
}
