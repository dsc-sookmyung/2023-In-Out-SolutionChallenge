import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/screen/screen_main.dart';
import 'package:largo/widget/bottom_bar.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/widget/dynamin_link.dart';
import 'package:logger/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());
var logger = Logger();


class MyApp extends StatefulWidget{
  _MyappState createState() => _MyappState();
}



class _MyappState extends State<MyApp>{
  @override
  void initState(){
    DynamicLink().setup();
    super.initState();



  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: ScreenLogin(),
    );
  }

}


