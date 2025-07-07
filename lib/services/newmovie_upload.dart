import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMovie {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Submit a new movie to the "new" collection (for approval or listing)
  Future<bool> submitMovie({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController posterUrlController,
    required TextEditingController bannerUrlController,
    required TextEditingController descriptionController,
    required TextEditingController genreController,
    required TextEditingController yearController,
    required TextEditingController trailerUrlController,
    required TextEditingController ratingController,
    required TextEditingController torrent500MbController,
    required TextEditingController torrentHdController,
    required TextEditingController torrentFullHdController,
    required List<Map<String, String>> castList,
    required VoidCallback onSuccessResetCast,
    VoidCallback? onComplete, // optional
  }) async {
    if (!formKey.currentState!.validate()) return false;

    final user = _auth.currentUser;
    if (user == null) {
      _showError(context, '⚠️ You must be logged in to submit.');
      return false;
    }

    final rating = double.tryParse(ratingController.text.trim());
    if (rating == null || rating < 0 || rating > 10) {
      _showError(context, '⚠️ Please enter a valid rating between 0 and 10.');
      return false;
    }

    final movieData = {
      'uid': user.uid,
      'submittedBy': user.email ?? '',
      'isApproved': false,
      'title': titleController.text.trim(),
      'posterUrl': posterUrlController.text.trim(),
      'bannerUrl': bannerUrlController.text.trim(),
      'description': descriptionController.text.trim(),
      'genre': genreController.text.trim(),
      'year': yearController.text.trim(),
      'trailerUrl': trailerUrlController.text.trim(),
      'rating': rating,
      'torrentLinks': {
        '500MB': torrent500MbController.text.trim(),
        'HD': torrentHdController.text.trim(),
        'FullHD': torrentFullHdController.text.trim(),
      },
      'cast': castList,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      await _firestore.collection('new').add(movieData);
      _showSuccess(context, '🎬 Movie submitted successfully!');
      formKey.currentState!.reset();
      onSuccessResetCast();
      if (onComplete != null) onComplete();
      return true;
    } catch (e) {
      _showError(context, '❌ Failed to submit movie: $e');
      return false;
    }
  }

  void _showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF3BDB43)),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFFDFDFD),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Color(0xFFAD1C1C)),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFE6E6E6),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
