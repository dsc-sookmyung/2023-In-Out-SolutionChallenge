import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Market1 extends StatelessWidget {
  const Market1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(


        width : 329,
        height: 250,
        decoration: BoxDecoration(
          //color : Colors.red,
          borderRadius: BorderRadius.circular(13),
          image: DecorationImage(
              image: AssetImage('assets/images/example.png'),
            fit : BoxFit.fitWidth
          ),

        ),
      child: Stack(
        children: [
          Opacity(opacity: 0.3,
            child: Container(
              width : double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(13)
              ),

            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('망원시장',
                  style: TextStyle(
                      color : Colors.white,
                      letterSpacing:-0.5,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start),
              Text('엄청난 먹거리가 기다리고 있어요',
                  style: TextStyle(
                      color : Colors.white,
                      letterSpacing: -0.5,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start),
              Text('망원시장 설명이 들어가는 자리입니다.',
                  style: TextStyle(
                      color : Colors.white,
                      letterSpacing: -0.5,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start),
            ],


          )
          )
        ],
      )

    );
  }
}