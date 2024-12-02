import 'package:flutter/material.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFEA3032),
  onPrimary: Colors.white,
  secondary: Color(0xFFF699A1),
  onSecondary: Colors.black,
  error: Colors.redAccent,
  onError: Colors.white,
  surface: Colors.grey,
  onSurface: Colors.black,
  shadow: Color(0xFFB7B3B8),
  onSurfaceVariant: Color(0xFF7A7C80),
);

const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFEA3032),
  onPrimary: Colors.white,
  secondary: Color(0xFFF699A1),
  onSecondary: Colors.black,
  error: Colors.redAccent,
  onError: Colors.black,
  surface: Color(0xFF1E1E1E),
  onSurface: Colors.white,
  shadow: Color(0xFFBF4848),
  onSurfaceVariant: Color(0xFFCCCCCC),
);
