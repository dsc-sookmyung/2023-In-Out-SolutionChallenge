import 'package:flutter/material.dart';

class Bottom extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      child: Container(height: 50,
        child: TabBar(
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.blueGrey,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab( icon : Icon(
              Icons.home,
              size: 18,
            ),
            child: Text('메인',
              style: TextStyle(fontSize: 9),
            ),),

            Tab( icon : Icon(
              Icons.home,
              size: 18,
            ),
              child: Text('걷기',
                style: TextStyle(fontSize: 9),
              ),),

            Tab( icon : Icon(
              Icons.home,
              size: 18,
            ),
              child: Text('프로필',
                style: TextStyle(fontSize: 9),
              ),),



          ],

      ),
      ),
    );
  }
}