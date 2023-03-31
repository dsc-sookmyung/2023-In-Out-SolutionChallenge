import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Colors
import 'package:largo/color/themeColors.dart';

class SmallTitle extends StatelessWidget {
  @override
  final Size preferredSize;

  final String title;

  SmallTitle(
    this.title, {
    Key? key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 6, right: 6, top: 1, bottom: 1),
      child: Text(
        this.title,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      decoration: BoxDecoration(
        color: greyScale6,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
