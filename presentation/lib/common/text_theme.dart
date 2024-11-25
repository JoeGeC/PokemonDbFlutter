import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme._();
  static final CustomTextTheme _instance = CustomTextTheme._();
  factory CustomTextTheme() => _instance;

  TextTheme? _baseTextTheme;

  void initialize(TextTheme textTheme) {
    _baseTextTheme = textTheme;
  }

  TextStyle get labelSmallAlt => _baseTextTheme?.labelSmall!.copyWith(
    color: Colors.white,
    shadows: [
      Shadow(
        offset: Offset(2.0, 2.0),
        color: Color(0x80000000),
      ),
    ],
  ) ?? TextStyle();
}
