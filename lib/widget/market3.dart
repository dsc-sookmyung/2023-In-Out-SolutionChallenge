import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Market3 extends StatelessWidget {
  const Market3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(


        width : 329,
        height: 250,
        decoration: BoxDecoration(
          //color : Colors.red,
          borderRadius: BorderRadius.circular(13),
          image: DecorationImage(
              image: AssetImage('assets/images/example2.png'),
            fit : BoxFit.fitWidth
          ),

        ),
        child: Stack(
          children: [
            Opacity(opacity: 0.4,
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
                  Text('시장2',
                      style: TextStyle(
                          color : Colors.white,
                          letterSpacing:-0.5,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start),
                  Text('시장2 들어갈 자리입니다',
                      style: TextStyle(
                          color : Colors.white,
                          letterSpacing: -0.5,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start),
                  Text('시장2 설명이 들어가는 자리입니다.',
                      style: TextStyle(
                          color : Colors.white,
                          letterSpacing: -0.5,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start),
                ],


              ),
            )
          ],
        )
    );
  }
}