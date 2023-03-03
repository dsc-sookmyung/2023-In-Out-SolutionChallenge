import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/widget/market1.dart';
import 'package:largo/widget/market2.dart';
import 'package:largo/widget/market3.dart';
import 'package:largo/widget/market4.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class ScreenLogin extends StatefulWidget{
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ScreenLogin> {
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
        backgroundColor: Color(0xffFFC977),


        body: Container(
          width :double.infinity,
          margin: EdgeInsets.fromLTRB(23, 0, 23, 23),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 10),
            width: double.infinity,
            child : Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 280, 310, 20),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage('assets/images/largo.png'),
                        fit : BoxFit.fitHeight
                    ),
                  ),

                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: double.infinity,
                  child: Text(
                    '색다른',
                    style: TextStyle(
                        color : Colors.white,
                        letterSpacing: -0.5,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    '경험을 찾아서, Largo',
                    style: TextStyle(
                        color : Colors.white,
                        letterSpacing: -0.5,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 18),

                  width: double.infinity,

                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),

                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: AssetImage('assets/images/google.png'),
                              fit : BoxFit.fitHeight
                          ),
                        ),

                      ),

                      Text(
                        'Google 계정으로 로그인',
                        style: TextStyle(
                            color : Colors.grey,
                            letterSpacing: -0.5,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,),
                    ],
                  ),

                  decoration: BoxDecoration(
                    color : Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            )

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





