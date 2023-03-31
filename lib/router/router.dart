import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// 화면 import
import 'package:largo/main.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/views/walkingDoneView.dart';
import 'package:largo/views/walkingSettingView.dart';
import 'package:largo/views/walkingView.dart';

import '../screen/screen_main.dart';


class Routes {
  Routes._();

  static final routes = {
    '/' : (BuildContext context) => ScreenLogin(),
    '/home' : (BuildContext context) => MyHomePage(),
    '/main' : (BuildContext context) => ScreenMain(),
    '/walking/setting' : (BuildContext context) => WalkingSettingView(),
    '/walking/walking': (BuildContext context) => WalkingView(),
    '/walking/walkingDone' : (BuildContext context) => WalkingDoneView(),
  };
}