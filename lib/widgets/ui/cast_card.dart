import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:moviefliix/models/movie.dart';
import 'package:shimmer/shimmer.dart';

class CastSectionWidget extends StatelessWidget {
  final List<CastMember> cast;

  const CastSectionWidget({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    final showDefault = cast.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(Icons.people_alt, color: Colors.deepPurpleAccent),
              SizedBox(width: 8),
              Text(
                "Cast",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemCount: showDefault ? 1 : cast.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              final member =
                  showDefault
                      ? CastMember(name: "Unknown", imageUrl: "")
                      : cast[index];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child:
                          member.imageUrl.isEmpty
                              ? Container(
                                color: Colors.grey[900],
                                child: const Icon(
                                  Icons.person_outline,
                                  color: Colors.white54,
                                  size: 36,
                                ),
                              )
                              : CachedNetworkImage(
                                imageUrl: member.imageUrl,
                                fit: BoxFit.cover,
                                placeholder:
                                    (_, __) => Shimmer.fromColors(
                                      baseColor: Colors.grey.shade800,
                                      highlightColor: Colors.grey.shade700,
                                      child: Container(color: Colors.grey[900]),
                                    ),
                                errorWidget:
                                    (_, __, ___) => Container(
                                      color: Colors.grey[900],
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white54,
                                        size: 36,
                                      ),
                                    ),
                              ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 80,
                    child: Text(
                      member.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
