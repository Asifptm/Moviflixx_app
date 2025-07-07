import 'package:flutter/material.dart';
import 'package:moviefliix/utils/validators.dart';

class TorrentLinkInputWidget extends StatelessWidget {
  final TextEditingController qualityController;
  final TextEditingController urlController;
  final VoidCallback onDelete;

  const TorrentLinkInputWidget({
    super.key,
    required this.qualityController,
    required this.urlController,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.link_rounded, color: Colors.deepPurpleAccent),
                SizedBox(width: 8),
                Text(
                  "Torrent Link",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Quality
            TextFormField(
              controller: qualityController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Quality (e.g. 1080p)",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (v) => Validators.required(v, "Quality"),
            ),
            const SizedBox(height: 12),

            // Torrent URL
            TextFormField(
              controller: urlController,
              keyboardType: TextInputType.url,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Torrent URL",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (v) => Validators.url(v, "Torrent URL"),
            ),

            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
                tooltip: "Remove Torrent Link",
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
