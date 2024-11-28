import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildShimmer(),
          buildShimmer(),
          buildShimmer(),
        ],
      ),
    );
  }

  Shimmer buildShimmer() => Shimmer.fromColors(
        baseColor: Colors.white12,
        highlightColor: Colors.grey,
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.only(bottom: 16),
        ),
      );
}
