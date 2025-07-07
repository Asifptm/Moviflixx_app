import 'package:flutter/material.dart';

class DotIndicators extends StatelessWidget {
  final int count;
  final int currentIndex;

  const DotIndicators({
    required this.count,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == index ? 14 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.white54,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
