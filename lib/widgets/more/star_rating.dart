import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;
  final Duration animationDuration;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 20,
    this.color = Colors.amber,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    const int maxStars = 5;
    List<Widget> stars = [];

    for (int i = 1; i <= maxStars; i++) {
      Icon icon;
      if (rating >= i) {
        icon = Icon(
          Icons.star,
          color: color,
          size: size,
          key: ValueKey('full-$i'),
        );
      } else if (rating >= i - 0.5) {
        icon = Icon(
          Icons.star_half,
          color: color,
          size: size,
          key: ValueKey('half-$i'),
        );
      } else {
        icon = Icon(
          Icons.star_border,
          color: color,
          size: size,
          key: ValueKey('empty-$i'),
        );
      }

      stars.add(
        AnimatedSwitcher(
          duration: animationDuration,
          transitionBuilder:
              (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
          child: icon,
        ),
      );
    }

    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}
