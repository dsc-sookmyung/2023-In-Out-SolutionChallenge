import 'package:flutter/material.dart';

// 화면 import
import 'package:largo/main.dart';
import 'package:largo/views/walkingDoneView.dart';
import 'package:largo/views/walkingSettingView.dart';
import 'package:largo/views/walkingView.dart';


class Routes {
  Routes._();

  static final routes = {
    '/' : (BuildContext context) => MyHomePage(),
    '/warking/setting' : (BuildContext context) => WalkingSettingView(),
    '/warking/warking': (BuildContext context) => WalkingView(),
    '/warking/warkingDone' : (BuildContext context) => WalkingDoneView(),
  };
}