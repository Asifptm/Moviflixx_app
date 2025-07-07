import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:moviefliix/utils/inputs.dart';
import 'package:moviefliix/utils/validators.dart';

class EpisodeInputWidget extends StatefulWidget {
  final int episodeIndex;
  final TextEditingController titleController;
  final TextEditingController numberController;
  final List<TextEditingController> torrentQualityControllers;
  final List<TextEditingController> torrentUrlControllers;
  final VoidCallback onRemoveEpisode;

  const EpisodeInputWidget({
    super.key,
    required this.episodeIndex,
    required this.titleController,
    required this.numberController,
    required this.torrentQualityControllers,
    required this.torrentUrlControllers,
    required this.onRemoveEpisode,
  });

  @override
  State<EpisodeInputWidget> createState() => _EpisodeInputWidgetState();
}

class _EpisodeInputWidgetState extends State<EpisodeInputWidget> {
  void _addTorrentLink() {
    setState(() {
      widget.torrentQualityControllers.add(TextEditingController());
      widget.torrentUrlControllers.add(TextEditingController());
    });
  }

  void _removeTorrentLink(int index) {
    setState(() {
      widget.torrentQualityControllers[index].dispose();
      widget.torrentUrlControllers[index].dispose();
      widget.torrentQualityControllers.removeAt(index);
      widget.torrentUrlControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Episode ${widget.episodeIndex + 1}",
                  style: const TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: widget.onRemoveEpisode,
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.redAccent,
                  ),
                  tooltip: "Remove Episode",
                ),
              ],
            ),
            const SizedBox(height: 12),
            CustomInputField(
              label: "Episode Title",
              icon: FeatherIcons.type,
              controller: widget.titleController,
              validator: (v) => Validators.required(v, "Episode Title"),
            ),
            CustomInputField(
              label: "Episode Number",
              icon: FeatherIcons.hash,
              controller: widget.numberController,
              keyboardType: TextInputType.number,
              validator: (v) => Validators.required(v, "Episode Number"),
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(Icons.download, color: Colors.deepPurpleAccent, size: 18),
                SizedBox(width: 8),
                Text(
                  "Torrent Links",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...List.generate(widget.torrentQualityControllers.length, (index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomInputField(
                      label: "Quality",
                      icon: FeatherIcons.settings,
                      controller: widget.torrentQualityControllers[index],
                      validator: (v) => Validators.required(v, "Quality"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomInputField(
                      label: "Torrent URL",
                      icon: FeatherIcons.link,
                      controller: widget.torrentUrlControllers[index],
                      keyboardType: TextInputType.url,
                      validator: (v) => Validators.url(v, "Torrent URL"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.redAccent,
                      ),
                      onPressed: () => _removeTorrentLink(index),
                      tooltip: "Remove Torrent",
                    ),
                  ),
                ],
              );
            }),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _addTorrentLink,
                icon: const Icon(Icons.add, color: Colors.deepPurpleAccent),
                label: const Text(
                  "Add Torrent",
                  style: TextStyle(color: Colors.deepPurpleAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
