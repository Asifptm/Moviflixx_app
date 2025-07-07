import 'package:flutter/material.dart';

class ImageNotAvailable extends StatelessWidget {
  const ImageNotAvailable({super.key, this.width = 100, this.height = 150});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[800],
      child: const Center(
        child: Icon(Icons.broken_image, color: Colors.white54, size: 46),
      ),
    );
  }
}
