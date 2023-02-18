import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Widget
import 'package:largo/widgets/customAppbar.dart';

class WalkingView extends StatefulWidget {
  @override
  _WalkingView createState() => _WalkingView();
}

class _WalkingView extends State<WalkingView> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    double _height = MediaQuery.of(context).size.height - (statusBarHeight * 2);
    double _width = MediaQuery.of(context).size.width;
    double _cardHeight = _height * 0.72;
    double _cardWidth = _width * 0.52;
    double _innerImageHeight = _cardHeight * 0.83;
    double _innerImageWidth = _cardWidth * 0.95;

    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar("걸어볼까?"),
        body: Container(
            child: Center(
          child: Text("warking View"),
        )));
  }
}
