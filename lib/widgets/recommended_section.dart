import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moviefliix/widgets/more/shimmer.dart';
import '../utils/image_not_available.dart';

class RecommendedSection extends StatelessWidget {
  final List<Map<String, dynamic>> movies;
  final String title;

  const RecommendedSection({
    super.key,
    required this.movies,
    this.title = 'Recommended for You',
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        MasonryGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            final String? posterUrl = movie['poster'];
            final double height = 200 + (index % 3) * 40;

            return Container(
              decoration: BoxDecoration(
                border: const Border(
                  bottom: BorderSide(color: Colors.white24, width: 2),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    // Image or fallback
                    posterUrl == null || posterUrl.isEmpty
                        ? ImageNotAvailable(
                          width: double.infinity,
                          height: height,
                        )
                        : CachedNetworkImage(
                          imageUrl: posterUrl,
                          width: double.infinity,
                          height: height,
                          fit: BoxFit.cover,
                          fadeInDuration: const Duration(milliseconds: 500),
                          placeholder:
                              (context, url) =>
                                  ShimmerCardPlaceholder(height: height),
                          errorWidget:
                              (context, url, error) => ImageNotAvailable(
                                width: double.infinity,
                                height: height,
                              ),
                        ),

                    // Gradient overlay at the bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 60,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(0, 0, 0, 0),
                              Color.fromARGB(239, 0, 0, 0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),

                    // Movie title at bottom left
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Text(
                        movie['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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
              ),
            );
          },
        ),
      ],
    );
  }
}
