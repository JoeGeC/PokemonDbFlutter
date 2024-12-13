import 'package:flutter/material.dart';
import 'package:presentation/src/pokemon/widgets/rounded_background.dart';

Widget LabelValueColumn({
  Color valueBackgroundColor = Colors.white,
  TextStyle? valueTextStyle,
  Color labelBackgroundColor = Colors.grey,
  TextStyle? labelTextStyle,
  String label = "",
  String value = "",
}) =>
    Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          decoration: BoxDecoration(
            color: labelBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              roundedBackground(
                color: valueBackgroundColor,
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: valueTextStyle,
                ),
              ),
              SizedBox(height: 4),
              Text(label, style: labelTextStyle),
            ],
          ),
        ),
      ),
    );
