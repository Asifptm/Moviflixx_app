import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TorrentLinksWidget extends StatelessWidget {
  final Map<String, String> torrentLinks;

  const TorrentLinksWidget({super.key, required this.torrentLinks});

  Future<void> _launchURL(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not launch the link."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (torrentLinks.isEmpty) {
      return const Text(
        "No torrents available",
        style: TextStyle(color: Colors.white70),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(Icons.download_rounded, color: Colors.deepPurpleAccent),
              SizedBox(width: 8),
              Text(
                "Torrent Links",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                torrentLinks.entries.map((entry) {
                  final quality = entry.key;
                  final url = entry.value;

                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: TextButton.icon(
                      onPressed: () => _launchURL(context, url),
                      icon: const Icon(
                        Icons.link_sharp,
                        color: Colors.deepPurpleAccent,
                        size: 20,
                      ),
                      label: Text(
                        quality,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.deepPurple.withOpacity(0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
