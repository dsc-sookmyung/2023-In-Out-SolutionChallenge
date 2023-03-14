import 'package:flutter/material.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/widget/bottom_bar.dart';
import 'package:largo/screen/screen_login.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget{
  _MyappState createState() => _MyappState();
}





class _MyappState extends State<MyApp>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: ScreenLogin(),
    );
  }

}
