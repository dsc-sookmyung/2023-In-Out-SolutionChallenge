import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/screen/screen_mypage.dart';
import 'package:largo/widget/bottom_bar.dart';

import '../views/walkingSettingView.dart';



class ScreenMain extends StatefulWidget{
  _MyappState createState() => _MyappState();
}





class _MyappState extends State<ScreenMain>{
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.group)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings))
  ];
  late TabController controller;
  @override
  Widget build(BuildContext context){
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: items),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return ScreenHome();
            case 1:
              return WalkingSettingView();
            case 2:
              return ScreenMypage();
            default:
              return ScreenHome();
          }
        });
  }

}
