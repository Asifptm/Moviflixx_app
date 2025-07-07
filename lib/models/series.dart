import 'package:cloud_firestore/cloud_firestore.dart';

class CastMember {
  final String name;
  final String imageUrl;

  CastMember({required this.name, required this.imageUrl});

  factory CastMember.fromMap(Map<String, dynamic> map) {
    return CastMember(name: map['name'] ?? '', imageUrl: map['imageUrl'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'imageUrl': imageUrl};
  }
}

class Episode {
  final String title;
  final int episodeNumber;
  final Map<String, String> torrentLinks;

  Episode({
    required this.title,
    required this.episodeNumber,
    required this.torrentLinks,
  });

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      title: map['title'] ?? '',
      episodeNumber: map['episodeNumber'] ?? 0,
      torrentLinks: Map<String, String>.from(map['torrentLinks'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'episodeNumber': episodeNumber,
      'torrentLinks': torrentLinks,
    };
  }
}

class Series {
  final String? id;
  final String title;
  final String posterUrl;
  final String bannerUrl;
  final String description;
  final int year;
  final String genre;
  final double rating;
  final String trailerUrl;
  final List<CastMember> cast;
  final List<Episode> episodes;
  final DateTime createdAt;

  Series({
    this.id,
    required this.title,
    required this.posterUrl,
    required this.bannerUrl,
    required this.description,
    required this.year,
    required this.genre,
    required this.rating,
    required this.trailerUrl,
    required this.cast,
    required this.episodes,
    required this.createdAt,
  });

  factory Series.fromMap(Map<String, dynamic> map, {String? id}) {
    return Series(
      id: id,
      title: map['title'] ?? '',
      posterUrl: map['posterUrl'] ?? '',
      bannerUrl: map['bannerUrl'] ?? '',
      description: map['description'] ?? '',
      year: map['year'] ?? 0,
      genre: map['genre'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      trailerUrl: map['trailerUrl'] ?? '',
      cast:
          (map['cast'] as List<dynamic>? ?? [])
              .map((e) => CastMember.fromMap(e))
              .toList(),
      episodes:
          (map['episodes'] as List<dynamic>? ?? [])
              .map((e) => Episode.fromMap(e))
              .toList(),
      createdAt:
          map['createdAt'] is Timestamp
              ? (map['createdAt'] as Timestamp).toDate()
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
      'genre': genre,
      'rating': rating,
      'trailerUrl': trailerUrl,
      'cast': cast.map((e) => e.toMap()).toList(),
      'episodes': episodes.map((e) => e.toMap()).toList(),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
