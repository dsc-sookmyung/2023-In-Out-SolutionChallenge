import 'package:flutter/material.dart';
import 'package:largo/screen/screen_home.dart';
import 'package:largo/screen/screen_login.dart';
import 'package:largo/widget/bottom_bar.dart';



class ScreenMain extends StatefulWidget{
  _MyappState createState() => _MyappState();
}





class _MyappState extends State<ScreenMain>{
  late TabController controller;
  @override
  Widget build(BuildContext context){
    return MaterialApp(title: 'Largo',
      theme: ThemeData(
        brightness: Brightness.dark ,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(length: 3,
        child : Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children : <Widget> [
              ScreenHome(),
              ScreenLogin(),
              Container(child: Center(child: Text('프로필'),),)
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }

}
