import 'package:flutter/material.dart';
import 'package:moviefliix/widgets/more/movie_portrait_card.dart';

class MoviesScreen extends StatelessWidget {
  MoviesScreen({super.key});

  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Inception',
      'poster':
          'https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg',
      'language': 'English',
      'genre': 'Sci-Fi, Action',
      'rating': 8.8,
    },
    {
      'title': 'RRR',
      'poster':
          'https://image.tmdb.org/t/p/w500/keVbLz0fvRW5pVaE6kUUrdRQz6k.jpg',
      'language': 'Telugu',
      'genre': 'Action, Drama',
      'rating': 8.0,
    },
    {
      'title': 'Coco',
      'poster':
          'https://image.tmdb.org/t/p/w500/gGEsBPAijhVUFoiNpgZXqRVWJt2.jpg',
      'language': 'English',
      'genre': 'Animation, Family',
      'rating': 8.4,
    },
    {
      'title': '3 Idiots',
      'poster':
          'https://image.tmdb.org/t/p/w500/66vW1r04N8dYnYB1Yz3LFa3KMIy.jpg',
      'language': 'Hindi',
      'genre': 'Comedy, Drama',
      'rating': 8.4,
    },
    {
      'title': 'Joker',
      'poster':
          'https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg',
      'language': 'English',
      'genre': 'Crime, Drama',
      'rating': 8.5,
    },
    {
      'title': 'Baahubali 2',
      'poster':
          'https://image.tmdb.org/t/p/w500/sfMljlO6vQj6FMOqvRAa8l9F4Xz.jpg',
      'language': 'Telugu',
      'genre': 'Action, Fantasy',
      'rating': 8.2,
    },
    {
      'title': 'Frozen II',
      'poster':
          'https://image.tmdb.org/t/p/w500/qdfARIhgpgZOBh3vfNhWS4hmSo3.jpg',
      'language': 'English',
      'genre': 'Animation, Adventure',
      'rating': 7.0,
    },
    {
      'title': 'Dangal',
      'poster':
          'https://image.tmdb.org/t/p/w500/p2lVAcPuRPSO8Al6hDDGw0OgMi8.jpg',
      'language': 'Hindi',
      'genre': 'Biography, Drama',
      'rating': 8.4,
    },
    {
      'title': 'Toy Story 4',
      'poster':
          'https://image.tmdb.org/t/p/w500/w9kR8qbmQ01HwnvK4alvnQ2ca0L.jpg',
      'language': 'English',
      'genre': 'Animation, Adventure',
      'rating': 7.8,
    },
    {
      'title': 'KGF Chapter 2',
      'poster':
          'https://image.tmdb.org/t/p/w500/jtAI6OJIWLWiRItNSZoWjrsUtmi.jpg',
      'language': 'Kannada',
      'genre': 'Action, Thriller',
      'rating': 8.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('All Movies', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MoviePortraitCard(movie: movie);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          // Filter logic here
        },
        label: const Text('Filter'),
        icon: const Icon(Icons.filter_list),
      ),
    );
  }
}
