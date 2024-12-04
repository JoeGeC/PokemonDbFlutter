import 'package:flutter/material.dart';

Widget animatedBar({
  int value = 255, //max value of 255
  double height = 20,
  double width = 300,
  int milliseconds = 500,
  Color backgroundColor = Colors.grey,
  Color barColor = Colors.red,
}) {
  double normalizedWidth = (value / 255).clamp(0.0, 1.0);
  return Container(
      height: height,
      width: width,
      color: backgroundColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          duration: Duration(milliseconds: milliseconds),
          curve: Curves.easeInOut,
          width: width * normalizedWidth,
          color: barColor,
        ),
      ),
    );
}
