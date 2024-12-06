import 'package:flutter/material.dart';
import 'package:presentation/pokemon/widgets/rounded_background.dart';

Widget PokemonSection({
  Color backgroundColor = Colors.white,
  Color borderColor = Colors.black,
  Color titleBackgroundColor = Colors.grey,
  TextStyle? titleTextStyle,
  String title = "",
  Widget? child,
  double topPadding = 16,
  double radius = 8,
  double borderWidth = 4,
  double bodyPadding = 16,
}) =>
    Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
            border: Border.all(color: borderColor, width: borderWidth)),
        child: Column(
          children: [
            roundedBackground(
              color: titleBackgroundColor,
              child: Center(child: Text(title, style: titleTextStyle)),
            ),
            Padding(
              padding: EdgeInsets.all(bodyPadding),
              child: child ?? Container(),
            ),
          ],
        ),
      ),
    );
