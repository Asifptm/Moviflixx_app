import 'package:flutter/material.dart';
import 'package:moviefliix/models/movie.dart';
import 'package:moviefliix/services/movie_service.dart';
import 'package:moviefliix/utils/show_snackbar.dart';

class MovieFormHelper {
  static Future<void> submitMovieForm({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController posterUrlController,
    required TextEditingController bannerUrlController,
    required TextEditingController descriptionController,
    required TextEditingController yearController,
    required TextEditingController ratingController,
    required TextEditingController genreController,
    required TextEditingController trailerUrlController,
    required List<TextEditingController> torrentQualityControllers,
    required List<TextEditingController> torrentUrlControllers,
    required List<TextEditingController> castNameControllers,
    required List<TextEditingController> castImageControllers,
    String? docId,
  }) async {
    if (!formKey.currentState!.validate()) return;

    final castList = List.generate(
      castNameControllers.length,
      (i) => CastMember(
        name: castNameControllers[i].text.trim(),
        imageUrl: castImageControllers[i].text.trim(),
      ),
    );

    final Map<String, String> torrentLinks = {};
    for (int i = 0; i < torrentQualityControllers.length; i++) {
      final quality = torrentQualityControllers[i].text.trim();
      final url = torrentUrlControllers[i].text.trim();
      if (quality.isNotEmpty && url.isNotEmpty) {
        torrentLinks[quality] = url;
      }
    }

    final movie = Movie(
      id: docId,
      title: titleController.text.trim(),
      posterUrl: posterUrlController.text.trim(),
      bannerUrl: bannerUrlController.text.trim(),
      description: descriptionController.text.trim(),
      year: int.parse(yearController.text.trim()),
      rating: double.parse(ratingController.text.trim()),
      genre: genreController.text.trim(),
      trailerUrl: trailerUrlController.text.trim(),
      torrentLinks: torrentLinks,
      cast: castList,
      createdAt: DateTime.now(),
    );

    try {
      await MovieService.uploadMovie(movie, docId: docId);

      if (context.mounted) {
        showCustomSnackBar(
          context,
          icon: Icons.check_circle_rounded,
          reason: "Movie uploaded successfully!",
          color: Colors.deepPurple,
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        showCustomSnackBar(
          context,
          icon: Icons.error_outline_rounded,
          reason: "Upload failed: ${e.toString()}",
          color: Colors.redAccent,
        );
      }
    }
  }
}
