import 'package:flutter/material.dart';

class EpisodeInputData {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController episodeNumberController = TextEditingController();
  final List<TextEditingController> torrentQualityControllers = [];
  final List<TextEditingController> torrentUrlControllers = [];

  void dispose() {
    titleController.dispose();
    episodeNumberController.dispose();
    for (final c in torrentQualityControllers) {
      c.dispose();
    }
    for (final c in torrentUrlControllers) {
      c.dispose();
    }
  }
}
