import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviefliix/models/movie.dart';
import 'package:moviefliix/widgets/ui/cast_card.dart';
import 'package:moviefliix/widgets/ui/torrent_link.dart';
import 'package:moviefliix/widgets/ui/trailer_ui.dart';

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
            const SizedBox(height: 24),

            // 🔹 YouTube Trailer
            if (movie.trailerUrl.isNotEmpty) ...[
              YouTubeTrailerPlayer(
                trailerUrl: movie.trailerUrl,
                autoPlay: false,
              ),
              const SizedBox(height: 24),
            ],

            // 🔹 Torrent Links
            if (movie.torrentLinks.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TorrentLinksWidget(torrentLinks: movie.torrentLinks),
              ),

            const SizedBox(height: 24),
            CastSectionWidget(cast: movie.cast),
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
