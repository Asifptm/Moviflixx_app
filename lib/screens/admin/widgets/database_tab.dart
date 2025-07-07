import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:moviefliix/screens/admin/moviedatabase.dart';
import 'package:moviefliix/screens/admin/options/series.dart';

class DatabaseTabSection extends StatelessWidget {
  const DatabaseTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 24),
        const Text(
          "Manage Content",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 24),
        _buildButton(
          context,
          icon: FeatherIcons.folder,
          label: "Movie Database",
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MovieDatabaseScreen()),
              ),
        ),
        const SizedBox(height: 16),
        _buildButton(
          context,
          icon: FeatherIcons.folderPlus,
          label: "Series Database",
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SeriesDatabaseScreen()),
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
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
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
