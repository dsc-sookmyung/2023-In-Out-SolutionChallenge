import 'package:flutter/material.dart';
import 'package:largo/widget/bottom_bar.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget{
  _MyappState createState() => _MyappState();
}





class _MyappState extends State<MyApp>{
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
          child:Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children : <Widget> [
                Container(child: Center(child: Text('메인'),),),
                Container(child: Center(child: Text('걷기'),),),
                Container(child: Center(child: Text('마이페이지'),),)
              ],
            ),
            bottomNavigationBar: Bottom(),
          ),
      ),
    );
  }

}
