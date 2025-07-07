import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:moviefliix/utils/image_not_available.dart';

class MoviePortraitCard extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MoviePortraitCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final String? posterUrl = movie['poster'];

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // Poster image
          posterUrl == null || posterUrl.isEmpty
              ? const ImageNotAvailable(
                width: double.infinity,
                height: double.infinity,
              )
              : CachedNetworkImage(
                imageUrl: posterUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder:
                    (context, url) => Container(color: Colors.grey[800]),
                errorWidget: (context, url, error) => const ImageNotAvailable(),
              ),

          // Gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Title text
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Text(
              movie['title'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
