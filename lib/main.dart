import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Views
import 'package:largo/views/walkingSetting.dart';
import 'package:largo/views/walkingView.dart';
import 'package:largo/views/walkingDoneView.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.group)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings))
  ];

  @override
  Widget build(BuildContext context) {
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
