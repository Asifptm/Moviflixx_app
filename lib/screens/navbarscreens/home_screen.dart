import 'package:flutter/material.dart';
import 'package:moviefliix/widgets/home/hero_banner_widget.dart';
import 'package:moviefliix/widgets/home/movie_horizontal_section.dart';

import 'package:moviefliix/data/movie_data.dart'; // Your movie data file

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Group movies by genre
    final newReleases = movieData; // Or filter for latest year if you want
    final trending = movieData; // You can pick a subset or mark trending movies
    final bollywood =
        movieData
            .where((m) => m['genre']?.toLowerCase() == 'bollywood')
            .toList();
    final comedy =
        movieData.where((m) => m['genre']?.toLowerCase() == 'comedy').toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeroBannerWidget(),

          MovieHorizontalSection(
            title: 'New Releases',
            items: newReleases,
            onSeeAll: () {
              // Navigate or show all New Releases
            },
            onItemTap: (movie) {
              Navigator.pushNamed(context, '/details', arguments: movie);
            },
          ),

          MovieHorizontalSection(
            title: 'Trending Now',
            items: trending,
            onItemTap: (movie) {
              Navigator.pushNamed(context, '/details', arguments: movie);
            },
          ),

          MovieHorizontalSection(
            title: 'Horror',
            items: bollywood,
            onItemTap: (movie) {
              Navigator.pushNamed(context, '/details', arguments: movie);
            },
          ),

          MovieHorizontalSection(
            title: 'Comedy Picks',
            items: comedy,
            onItemTap: (movie) {
              Navigator.pushNamed(context, '/details', arguments: movie);
            },
          ),
        ],
      ),
    );
  }
}
