import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/shimmer.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildShimmer(height: 50, width: 200),
          const SizedBox(height: 30),
          buildShimmer(height: 50, width: 200),
          const SizedBox(height: 30),
          buildShimmer(height: 50, width: 200),
          const SizedBox(height: 30),
          buildShimmer(height: 50, width: 200),
        ],
      ),
    );
  }
}
