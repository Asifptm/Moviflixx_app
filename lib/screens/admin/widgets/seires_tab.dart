import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:moviefliix/screens/admin/options/addmovies.dart';
import 'package:moviefliix/screens/admin/options/series_upload_screen.dart';

class UploadTabSection extends StatelessWidget {
  const UploadTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 24),
        const Text(
          "Upload Content",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 24),
        _buildButton(
          context,
          icon: FeatherIcons.uploadCloud,
          label: "Upload Movie",
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UploadMovieScreen()),
              ),
        ),
        const SizedBox(height: 16),
        _buildButton(
          context,
          icon: FeatherIcons.upload,
          label: "Upload Series",
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UploadSeriesScreen()),
              ),
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
