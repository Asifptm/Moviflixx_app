import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviefliix/models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(movie.title),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Banner
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: movie.bannerUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Description
            Text(
              movie.description,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 16),

            // 🔹 Info Chips
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _infoChip("Genre", movie.genre),
                _infoChip("Year", movie.year.toString()),
                _infoChip("Rating", movie.rating.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 Trailer
            if (movie.trailerUrl.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Trailer URL:",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.trailerUrl,
                    style: const TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ],
              ),
            const SizedBox(height: 16),

            // 🔹 Torrent Links
            if (movie.torrentLinks.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Torrent Links:",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ...movie.torrentLinks.entries.map(
                    (entry) => Text(
                      "${entry.key}: ${entry.value}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),

            // 🔹 Cast
            if (movie.cast.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cast:",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie.cast.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, index) {
                        final cast = movie.cast[index];
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: CachedNetworkImageProvider(
                                cast.imageUrl,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              cast.name,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Chip(
      backgroundColor: Colors.deepPurple.shade700.withOpacity(0.8),
      label: Text(
        "$label: $value",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
