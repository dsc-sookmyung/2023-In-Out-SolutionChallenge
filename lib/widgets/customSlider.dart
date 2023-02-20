import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Slider Controller
import 'package:largo/controllers/sliderController.dart';

// Colors
import 'package:largo/color/themeColors.dart';

class CustomSlider extends StatefulWidget {
  @override
  _CustomSlider createState() => _CustomSlider();
}

class _CustomSlider extends State<CustomSlider> {
  var contoller = SliderController(10);

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
        value: contoller.sliderValue,
        min: 10.0,
        max: 10000.0,
        divisions: 5,
        label: '${contoller.sliderValue.round()}',
        onChanged: (double newValue) {
          setState(
            () {
              contoller.sliderValue = newValue;
            },
          );
        },
      ),
    );
  }
}
