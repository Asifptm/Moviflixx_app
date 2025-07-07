import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviefliix/services/movie_service.dart';
import '../models/movie.dart';

final movieSearchQueryProvider = StateProvider<String>((ref) => '');

/// 🔄 Stream provider for all movies
final movieStreamProvider = StreamProvider<List<Movie>>((ref) {
  final query = ref.watch(movieSearchQueryProvider);
  return MovieService.fetchMoviesStream().map((movies) {
    if (query.isEmpty) return movies;
    return movies
        .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  });
});

/// 🛠️ Future provider to upload a movie (used with a button usually)
final uploadMovieProvider = Provider((ref) => MovieService.uploadMovie);

/// 🔍 Fetch a movie by ID
final movieByIdProvider = FutureProvider.family<Movie?, String>((ref, id) {
  return MovieService.getMovieById(id);
});
