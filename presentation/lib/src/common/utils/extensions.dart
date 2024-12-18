import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

extension StringExtensions on String {
  String capitalise() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  PresentationLocalizations get localizations =>
      PresentationLocalizations.of(this);

  bool get isDarkMode => theme.brightness == Brightness.dark;
}
