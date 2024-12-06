import 'package:flutter/cupertino.dart';

SizedBox roundedBackground({Color? color, Widget? child}) => SizedBox(
  width: double.infinity,
  child: Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    child: child ?? Container(),
  ),
);