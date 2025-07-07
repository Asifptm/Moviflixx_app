import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviefliix/widgets/recommended_section.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovieSearchScreenState createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _movies = [];

  final List<Map<String, dynamic>> allMovies = [
    {
      'title': 'Inception',
      'poster':
          'https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg',
      'language': 'English',
      'genre': 'Sci-Fi, Action',
      'rating': 8.8,
    },
    {
      'title': 'Interstellar',
      'poster':
          'https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
      'language': 'English',
      'genre': 'Adventure, Drama',
      'rating': 8.6,
    },
    {
      'title': '3 Idiots',
      'poster':
          'https://image.tmdb.org/t/p/w500/66L4OQgVdCw7FCpdcx1nDFRzQkC.jpg',
      'language': 'Hindi',
      'genre': 'Comedy, Drama',
      'rating': 8.4,
    },
    {
      'title': 'Drishyam',
      'poster':
          'https://image.tmdb.org/t/p/w500/od0jW6nCxdJYJl5fQnRddZ8pFVP.jpg',
      'language': 'Malayalam',
      'genre': 'Thriller, Drama',
      'rating': 8.3,
    },
    {
      'title': 'KGF: Chapter 1',
      'poster':
          'https://image.tmdb.org/t/p/w500/57h7D0vSyB6ZtVgFMiBfb3T45yW.jpg',
      'language': 'Kannada',
      'genre': 'Action, Drama',
      'rating': 8.2,
    },
    {
      'title': 'Jawan',
      'poster':
          'https://image.tmdb.org/t/p/w500/rg8N7x27EfHmYdZeF8VuxbaXyyO.jpg',
      'language': 'Hindi',
      'genre': 'Action, Thriller',
      'rating': 7.5,
    },
    {
      'title': 'Minnal Murali',
      'poster':
          'https://image.tmdb.org/t/p/w500/v0z6lGNAJ6k3jKCR1X9Ygkk93Zp.jpg',
      'language': 'Malayalam',
      'genre': 'Action, Superhero',
      'rating': 7.9,
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
      'title': 'Coco',
      'poster':
          'https://image.tmdb.org/t/p/w500/gGEsBPAijhVUFoiNpgZXqRVWJt2.jpg',
      'language': 'English',
      'genre': 'Animation, Family',
      'rating': 8.4,
    },
    {
      'title': 'Spirited Away',
      'poster':
          'https://image.tmdb.org/t/p/w500/oRvMaJOmapypFUcQqpgHMZA6qL9.jpg',
      'language': 'Japanese',
      'genre': 'Animation, Fantasy',
      'rating': 8.6,
    },
    {
      'title': 'Zindagi Na Milegi Dobara',
      'poster':
          'https://image.tmdb.org/t/p/w500/5LzmP3q5TsAa17c7gob6gFk9iCE.jpg',
      'language': 'Hindi',
      'genre': 'Adventure, Drama',
      'rating': 8.1,
    },
    {
      'title': '2018: Everyone is a Hero',
      'poster':
          'https://image.tmdb.org/t/p/w500/sN1atTzQhXKctzZvjUHQROlVzYH.jpg',
      'language': 'Malayalam',
      'genre': 'Disaster, Thriller',
      'rating': 8.7,
    },
  ];

  bool get isSearching => _searchController.text.trim().isNotEmpty;

  void _searchMovies(String query) {
    final results =
        allMovies.where((movie) {
          return movie['title'].toLowerCase().contains(
            query.toLowerCase().trim(),
          );
        }).toList();

    setState(() => _movies = results);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _movies.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Find Movies',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 30, 109),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            TextField(
              controller: _searchController,
              onChanged: _searchMovies,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search movies...',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color.fromARGB(255, 238, 238, 238),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                suffixIcon:
                    isSearching
                        ? IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: _clearSearch,
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            if (isSearching) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Results',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${_movies.length} found',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(235, 88, 120, 223),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Divider(color: Colors.grey[700], thickness: 1),
              const SizedBox(height: 12),
            ] else ...[
              Expanded(
                child: SingleChildScrollView(
                  child: RecommendedSection(movies: allMovies),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
