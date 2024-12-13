import 'package:flutter/material.dart';

Widget RoundedBox({
  double width = 100,
  double height = 40,
  Color color = Colors.white10,
  double borderRadius = 16,
  Color borderColor = Colors.transparent,
  double borderWidth = 0,
  Widget? child,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          width: borderWidth
        )
      ),
      child: child ?? Container(),
    );
