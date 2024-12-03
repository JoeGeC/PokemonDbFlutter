import 'package:flutter/cupertino.dart';

extension StringExtensions on String {
  String capitalise() {
    if(isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension ImageExtension on num {
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}