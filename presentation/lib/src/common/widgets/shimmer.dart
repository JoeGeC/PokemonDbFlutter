import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer buildShimmer(
        {double width = 200, double height = 40, double borderRadius = 8}) =>
    Shimmer.fromColors(
      baseColor: Colors.black26,
      highlightColor: Colors.grey,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
