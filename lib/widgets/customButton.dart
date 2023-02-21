import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Colors
import 'package:largo/color/themeColors.dart';

class CustomButton extends StatelessWidget {
  @override
  final Size preferredSize;

  final String title;

  CustomButton(
    this.title, {
    Key? key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          // Respond to button press
          print("walking start");
        },
        child: Text(
          this.title,
          style: TextStyle(fontWeight: FontWeight.bold, color: greyScale4),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // <-- Radius
          ),
          backgroundColor: buttonColor,
          minimumSize: const Size.fromHeight(60), // NEW
        ),
      ),
    );
  }
}
