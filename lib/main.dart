import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

// 라우터
import 'package:largo/router/router.dart';
import 'package:go_router/go_router.dart';


// Views
import 'package:largo/views/walkingSettingView.dart';
import 'package:largo/views/walkingView.dart';
import 'package:largo/views/walkingDoneView.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/screen/screen_main.dart';
import 'package:largo/screen/screen_mypage.dart';
import 'package:largo/screen/screen_login.dart';

//위젯
import 'package:largo/widget/bottom_bar.dart';
import 'package:largo/widget/dynamic_link.dart';

// Permission handler
import 'package:permission_handler/permission_handler.dart';

// Geo location
import 'package:geolocator/geolocator.dart';

//기타
import 'package:logger/logger.dart';

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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: Routes.routes
    );
  }
}

// void main() => runApp(MyApp());


// class MyApp extends StatefulWidget{
//   _MyappState createState() => _MyappState();
// }

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<void> requestLocationPermission() async {

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted;

    //bool isLocation = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  Future<void> requestCameraPermission() async {

    final serviceStatusCamera = await Permission.camera.isGranted;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }
  //근영 ****
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
  Widget build(BuildContext context) {
    requestLocationPermission();
    requestCameraPermission();

    return ScreenLogin();
  }
  Future<SharedPreferences> localStorage_token() async{
    final user = await SharedPreferences.getInstance();
    user.setString('token','');
    return user;
  }
}
















// // void main() => runApp(MyApp());


// // class MyApp extends StatefulWidget{
// //   _MyappState createState() => _MyappState();
// // }



// class _MyappState extends State<MyApp>{
//   @override
//    initState() {
//     DynamicLink().setup();
//     //setup();
//     super.initState();
//     getToken = false;
    
//   }
 


//   @override
//   Widget build(BuildContext context){
//    return GetMaterialApp(
//      home: ScreenLogin(),
//      getPages: [
//        GetPage(
//          name: '/main',
//          page: () => ScreenMain(),
//        ),

//    ],
//    );


//   }
  

// }

