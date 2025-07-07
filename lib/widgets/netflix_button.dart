import 'package:flutter/material.dart';
import 'package:moviefliix/theme/theme.dart';
// Import your AppTheme

class MovieflixButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final EdgeInsetsGeometry? margin;

  const MovieflixButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isFullWidth = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: AppTheme.buttonStyle,
        child: Text(label),
      ),
    );
  }
}
