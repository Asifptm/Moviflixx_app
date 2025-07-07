import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeTrailerPlayer extends StatefulWidget {
  final String trailerUrl;
  final bool autoPlay;

  const YouTubeTrailerPlayer({
    super.key,
    required this.trailerUrl,
    this.autoPlay = false,
  });

  @override
  State<YouTubeTrailerPlayer> createState() => _YouTubeTrailerPlayerState();
}

class _YouTubeTrailerPlayerState extends State<YouTubeTrailerPlayer> {
  late YoutubePlayerController _controller;
  String? _videoId;

  String extractYouTubeId(String url) {
    try {
      final uri = Uri.parse(url.trim());

      if (uri.host.contains('youtu.be')) {
        return uri.pathSegments.first;
      }

      if (uri.host.contains('youtube.com')) {
        return uri.queryParameters['v'] ?? '';
      }
    } catch (_) {}
    return '';
  }

  @override
  void initState() {
    super.initState();
    _videoId = extractYouTubeId(widget.trailerUrl);

    if (_videoId != null && _videoId!.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: _videoId!,
        flags: YoutubePlayerFlags(
          autoPlay: widget.autoPlay,
          mute: false,
          enableCaption: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_videoId == null || _videoId!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "Invalid or unsupported YouTube URL.",
          style: TextStyle(color: Colors.redAccent),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(Icons.play_circle_fill, color: Colors.deepPurpleAccent),
              SizedBox(width: 8),
              Text(
                "Trailer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.deepPurpleAccent,
            progressColors: const ProgressBarColors(
              playedColor: Colors.deepPurple,
              handleColor: Colors.deepPurpleAccent,
            ),
            onReady: () {
              debugPrint("YouTube Player is ready.");
            },
            onEnded: (metaData) {
              // Optional: Do something when video ends
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
