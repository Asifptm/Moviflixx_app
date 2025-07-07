import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class NoSearchResults extends StatelessWidget {
  final String query;
  final VoidCallback? onClear;

  const NoSearchResults({super.key, this.query = '', this.onClear});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurple.withOpacity(0.15),
              ),
              child: const Icon(
                FeatherIcons.search,
                color: Colors.deepPurple,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "No Results Found",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              query.isNotEmpty
                  ? "We couldn’t find results for \"$query\"."
                  : "Try searching with a different keyword.",
              style: const TextStyle(fontSize: 14, color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            if (onClear != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onClear,
                icon: const Icon(Icons.clear),
                label: const Text("Clear Search"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 88, 88, 88),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
