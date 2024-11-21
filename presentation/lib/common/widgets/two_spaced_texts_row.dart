import 'package:flutter/cupertino.dart';

Row TwoSpacedTextsRow(String label1, String label2, TextStyle textStyle) {
  return Row(
    children: [
      Text(
        label1,
        style: textStyle.copyWith(),
      ),
      SizedBox(width: 10),
      Text(
        label2,
        style: textStyle.copyWith(),
      ),
    ],
  );
}
