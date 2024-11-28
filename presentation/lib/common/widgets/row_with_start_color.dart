import 'package:flutter/cupertino.dart';

IntrinsicHeight buildRowWithStartColor(Color startColor,
    {children = const <Widget>[], double width = 20 }) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: width,
          height: 20,
          decoration: BoxDecoration(
            color: startColor,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
          ),
        ),
        ...children,
      ],
    ),
  );
}