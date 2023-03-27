import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/screen/screen_main.dart';
import 'package:largo/screen/screen_mypage.dart';
import 'package:largo/widget/bottom_bar.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/widget/dynamic_link.dart';
import 'package:logger/logger.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 로그 사용을 위한 선언, 언제 어디서나 로그 사용 가능
var logger = Logger();
bool? getToken;

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => ScreenMypage(),
      routes: [
        GoRoute(
          path: 'Main',
          builder: (_, __) => ScreenMain(),
        ),
      ],
    ),
  ],
);
// 로컬 스토리지
// user.setString('token', value); 형태로 저장가능
void main() => runApp(MyApp());


class MyApp extends StatefulWidget{
  _MyappState createState() => _MyappState();
}



class _MyappState extends State<MyApp>{
  @override
   initState() {
    DynamicLink().setup();
    //setup();
    super.initState();
    getToken = false;





  }
  void setup() async {
    FirebaseApp app = await Firebase.initializeApp();
    print('Initialized default app $app');
    _getInitialDynamicLink();
    logger.d('start');
  }

  void _getInitialDynamicLink()  async{
    FirebaseDynamicLinks.instance.onLink.listen((
        PendingDynamicLinkData dynamicLinkData) async{
      Uri? deepLink = dynamicLinkData?.link;
      if (deepLink != null) {
        _redirectScreen(deepLink);

      }
    }).onError((error) {
      logger.e(error);
    });

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      _redirectScreen(deepLink);
    }
  }
  void _redirectScreen(Uri deepLink) {
  switch(deepLink.path) {
    case "/Main":
      String? token = deepLink.queryParameters['token'];
      logger.d('heelo');
      Get.offAll(
              () => ScreenMain());
      break;
  }
}
  @override
  Widget build(BuildContext context){
   return GetMaterialApp(
     home: ScreenLogin(),
     getPages: [
       GetPage(
         name: '/main',
         page: () => ScreenMain(),
       ),

   ],
   );


  }
  Future<SharedPreferences> localStorage_token() async{
    final user = await SharedPreferences.getInstance();
    user.setString('token','');
    return user;
  }

}

