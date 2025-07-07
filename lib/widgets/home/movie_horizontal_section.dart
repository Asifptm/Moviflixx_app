import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MovieHorizontalSection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;
  final VoidCallback? onSeeAll;
  final void Function(Map<String, String> movie)? onItemTap;

  const MovieHorizontalSection({
    required this.title,
    required this.items,
    this.onSeeAll,
    this.onItemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = items.isEmpty;

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + See All button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _getIconForTitle(title),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (onSeeAll != null && !isLoading)
                TextButton(
                  onPressed: onSeeAll,
                  child: const Text(
                    'See All',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Movie list or shimmer
          SizedBox(
            height: 150,
            child:
                isLoading
                    ? _buildShimmerList()
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final movie = items[index];
                        final image = movie['image'];
                        final movieTitle = movie['title'] ?? '';

                        return GestureDetector(
                          onTap: () {
                            if (onItemTap != null) {
                              onItemTap!(movie);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child:
                                      image != null
                                          ? Image.asset(
                                            image,
                                            height: 120,
                                            width: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    _placeholderImage(),
                                          )
                                          : _placeholderImage(),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  movieTitle,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder:
          (_, index) => Container(
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[600]!,
                  child: Container(
                    height: 12,
                    width: 80,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      height: 120,
      width: 100,
      color: Colors.grey[800],
      child: const Icon(Icons.image_not_supported, color: Colors.white54),
    );
  }

  Widget _getIconForTitle(String title) {
    IconData icon;
    switch (title.toLowerCase()) {
      case 'new releases':
        icon = Icons.new_releases;
        break;
      case 'trending now':
        icon = Icons.trending_up;
        break;
      case 'Horror':
        icon = Icons.movie_filter;
        break;
      case 'comedy picks':
        icon = Icons.sentiment_very_satisfied;
        break;
      default:
        icon = Icons.movie;
    }
    return Icon(icon, color: Colors.white);
  }
}
