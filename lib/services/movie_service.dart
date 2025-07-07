import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moviefliix/models/series.dart';
import '../models/movie.dart'; // adjust the import path as needed

class MovieService {
  static final _collection = FirebaseFirestore.instance.collection('movies');

  /// 🔹 Upload or update a movie
  static Future<void> uploadMovie(Movie movie, {String? docId}) async {
    try {
      final data = movie.toMap();

      if (docId != null && docId.isNotEmpty) {
        // Update existing movie
        await _collection.doc(docId).set(data);
      } else {
        // Add new movie with auto-generated ID
        await _collection.add(data);
      }
    } catch (e) {
      throw Exception('Failed to upload movie: $e');
    }
  }

  /// 🔹 Fetch all movies as a stream
  static Stream<List<Movie>> fetchMoviesStream() {
    return _collection.orderBy('createdAt', descending: true).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs
          .map(
            (doc) =>
                Movie.fromMap(doc.data() as Map<String, dynamic>, id: doc.id),
          )
          .toList();
    });
  }

  /// 🔹 Fetch a movie by document ID
  static Future<Movie?> getMovieById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return null;

      return Movie.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
    } catch (e) {
      throw Exception('Failed to fetch movie by ID: $e');
    }
  }

  /// 🔹 Delete a movie by document ID
  static Future<void> deleteMovie(String docId) async {
    try {
      await _collection.doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to delete movie: $e');
    }
  }
}

class SeriesService {
  static final _collection = FirebaseFirestore.instance.collection('series');

  /// 🔹 Upload or update a series
  static Future<void> uploadSeries(Series series, {String? docId}) async {
    try {
      final data = series.toMap();

      if (docId != null && docId.isNotEmpty) {
        // Update existing series
        await _collection.doc(docId).set(data);
      } else {
        // Add new series with auto-generated ID
        await _collection.add(data);
      }
    } catch (e) {
      throw Exception('Failed to upload series: $e');
    }
  }

  /// 🔹 Fetch all series as a stream
  static Stream<List<Series>> fetchSeriesStream() {
    return _collection.orderBy('createdAt', descending: true).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        return Series.fromMap(doc.data(), id: doc.id);
      }).toList();
    });
  }

  /// 🔹 Fetch a series by document ID
  static Future<Series?> getSeriesById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) return null;

      return Series.fromMap(doc.data()!, id: doc.id);
    } catch (e) {
      throw Exception('Failed to fetch series: $e');
    }
  }

  /// 🔹 Delete a series by document ID
  static Future<void> deleteSeries(String docId) async {
    try {
      await _collection.doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to delete series: $e');
    }
  }
}
