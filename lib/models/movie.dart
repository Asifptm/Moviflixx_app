import 'package:cloud_firestore/cloud_firestore.dart';

class CastMember {
  final String name;
  final String imageUrl;

  CastMember({required this.name, required this.imageUrl});

  factory CastMember.fromMap(Map<String, dynamic> data) {
    return CastMember(
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'imageUrl': imageUrl};
  }
}

class Movie {
  final String? id; // 🔹 Optional Firestore docId
  final String title;
  final String posterUrl;
  final String bannerUrl;
  final String description;
  final int year;
  final double rating;
  final String genre;
  final String trailerUrl;
  final Map<String, String> torrentLinks;
  final List<CastMember> cast;
  final DateTime createdAt;

  Movie({
    this.id,
    required this.title,
    required this.posterUrl,
    required this.bannerUrl,
    required this.description,
    required this.year,
    required this.rating,
    required this.genre,
    required this.trailerUrl,
    required this.torrentLinks,
    required this.cast,
    required this.createdAt,
  });

  factory Movie.fromMap(Map<String, dynamic> data, {String? id}) {
    int parseYear(dynamic year) {
      if (year is int) return year;
      if (year is String) return int.tryParse(year) ?? 0;
      return 0;
    }

    double parseRating(dynamic rating) {
      if (rating is double) return rating;
      if (rating is int) return rating.toDouble();
      if (rating is String) return double.tryParse(rating) ?? 0.0;
      return 0.0;
    }

    return Movie(
      id: id,
      title: data['title'] ?? 'Unknown',
      posterUrl: data['posterUrl'] ?? '',
      bannerUrl: data['bannerUrl'] ?? '',
      description: data['description'] ?? '',
      year: parseYear(data['year']),
      rating: parseRating(data['rating']),
      genre: data['genre'] ?? 'Unknown',
      trailerUrl: data['trailerUrl'] ?? '',
      torrentLinks: Map<String, String>.from(data['torrentLinks'] ?? {}),
      cast:
          (data['cast'] as List<dynamic>? ?? [])
              .map((e) => CastMember.fromMap(e as Map<String, dynamic>))
              .toList(),
      createdAt:
          data['createdAt'] is Timestamp
              ? (data['createdAt'] as Timestamp).toDate()
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'posterUrl': posterUrl,
      'bannerUrl': bannerUrl,
      'description': description,
      'year': year,
      'rating': rating,
      'genre': genre,
      'trailerUrl': trailerUrl,
      'torrentLinks': torrentLinks,
      'cast': cast.map((e) => e.toMap()).toList(),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Create a copy with updated fields
  Movie copyWith({
    String? id,
    String? title,
    String? posterUrl,
    String? bannerUrl,
    String? description,
    int? year,
    double? rating,
    String? genre,
    String? trailerUrl,
    Map<String, String>? torrentLinks,
    List<CastMember>? cast,
    DateTime? createdAt,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      posterUrl: posterUrl ?? this.posterUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      description: description ?? this.description,
      year: year ?? this.year,
      rating: rating ?? this.rating,
      genre: genre ?? this.genre,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      torrentLinks: torrentLinks ?? this.torrentLinks,
      cast: cast ?? this.cast,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
