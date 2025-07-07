import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardPlaceholder extends StatelessWidget {
  final double height;

  const ShimmerCardPlaceholder({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
