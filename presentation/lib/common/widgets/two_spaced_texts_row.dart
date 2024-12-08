import 'package:flutter/cupertino.dart';

Widget TwoSpacedTextsRow({
  String label1 = "",
  String label2 = "",
  TextStyle? textStyle,
  semanticsLabel = "",
}) =>
    Semantics(
      label: semanticsLabel,
      child: Row(
        children: [
          Text(
            label1,
            style: textStyle?.copyWith(),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label2,
              style: textStyle?.copyWith(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
