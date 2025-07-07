import 'package:flutter/material.dart';
import 'package:moviefliix/models/series.dart';
import 'package:moviefliix/services/movie_service.dart';
import 'package:moviefliix/utils/show_snackbar.dart';
import 'package:moviefliix/utils/widgets/epidata.dart';

class SeriesFormHelper {
  static Future<void> submitSeriesForm({
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
    required List<TextEditingController> castNameControllers,
    required List<TextEditingController> castImageControllers,
    required List<EpisodeInputData> episodes,
    String? docId,
  }) async {
    // 🔐 Validate form
    if (!formKey.currentState!.validate()) return;

    // 🔹 Build cast list
    final castList = List<CastMember>.generate(
      castNameControllers.length,
      (i) => CastMember(
        name: castNameControllers[i].text.trim(),
        imageUrl: castImageControllers[i].text.trim(),
      ),
    );

    // 🔹 Build episodes list
    final episodeList = <Episode>[];
    for (final episodeData in episodes) {
      final title = episodeData.titleController.text.trim();
      final number =
          int.tryParse(episodeData.episodeNumberController.text.trim()) ?? 0;

      final torrentLinks = <String, String>{};
      for (int i = 0; i < episodeData.torrentQualityControllers.length; i++) {
        final quality = episodeData.torrentQualityControllers[i].text.trim();
        final url = episodeData.torrentUrlControllers[i].text.trim();
        if (quality.isNotEmpty && url.isNotEmpty) {
          torrentLinks[quality] = url;
        }
      }

      episodeList.add(
        Episode(
          title: title,
          episodeNumber: number,
          torrentLinks: torrentLinks,
        ),
      );
    }

    // 🔹 Create series model
    final series = Series(
      id: docId,
      title: titleController.text.trim(),
      posterUrl: posterUrlController.text.trim(),
      bannerUrl: bannerUrlController.text.trim(),
      description: descriptionController.text.trim(),
      year: int.tryParse(yearController.text.trim()) ?? 0,
      rating: double.tryParse(ratingController.text.trim()) ?? 0.0,
      genre: genreController.text.trim(),
      trailerUrl: trailerUrlController.text.trim(),
      cast: castList,
      episodes: episodeList,
      createdAt: DateTime.now(),
    );

    // 🔸 Submit to Firestore
    try {
      await SeriesService.uploadSeries(series, docId: docId);

      if (context.mounted) {
        showCustomSnackBar(
          context,
          icon: Icons.check_circle,
          reason: "✅ Series uploaded successfully!",
          color: Colors.green,
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        showCustomSnackBar(
          context,
          icon: Icons.error,
          reason: "❌ Failed to upload series: $e",
          color: Colors.redAccent,
        );
      }
    }
  }
}
