import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Slider Controller
import 'package:largo/models/sliderController.dart';

// Colors
import 'package:largo/color/themeColors.dart';

class CustomSlider extends StatefulWidget {


  @override
  _CustomSlider createState() => _CustomSlider();
}

class _CustomSlider extends State<CustomSlider> {
  var contoller = SliderController(0);
  List<double> sliderVals = [17.5, 18.5, 20.5, 22, 24, 26];
  List<String> sliderValIndicators = ["10m", "100m", "500m", "1Km", "5Km", "10Km"];

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          activeTrackColor: mainColor,
          inactiveTrackColor: grayScale1,
          thumbColor: mainColor,
          activeTickMarkColor: mainColor,
          valueIndicatorColor: mainColor,
          showValueIndicator: ShowValueIndicator.always,
          trackHeight: 5,
          overlayColor: mainColor.withOpacity(0.2),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
      child: Slider(
        value: contoller.sliderValue.toDouble(),
        min: 0,
        max: 5,
        divisions: 5,
        label: sliderValIndicators[contoller.sliderValue.toInt()], //'${contoller.sliderValue.round()}',
        onChanged: (double newValue) {
          setState(
            () {
              contoller.sliderValue = newValue.toInt();
            },
          );
        },
      ),
    );
  }
}
