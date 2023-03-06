import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// 라우터
import 'package:largo/router/router.dart';

// Views
import 'package:largo/views/walkingSettingView.dart';
import 'package:largo/views/walkingView.dart';
import 'package:largo/views/walkingDoneView.dart';

// Permission handler
import 'package:permission_handler/permission_handler.dart';

// Geo location
import 'package:geolocator/geolocator.dart';

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
      initialRoute: "/",
      routes: Routes.routes
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.group)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings))
  ];

  Future<void> requestLocationPermission() async {

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted ;

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

  @override
  Widget build(BuildContext context) {
    requestLocationPermission();
    requestCameraPermission();

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: items),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return WalkingSettingView();
            case 1:
              return WalkingView();
            case 2:
              return WalkingDoneView();
            default:
              return WalkingSettingView();
          }
        });
  }
}