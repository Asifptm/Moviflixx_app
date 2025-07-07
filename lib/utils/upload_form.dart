import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:moviefliix/utils/cast_input_widget.dart';
import 'package:moviefliix/utils/inputs.dart';
import 'package:moviefliix/utils/validators.dart';
import 'package:moviefliix/utils/widgets/section_header.dart';
import 'package:moviefliix/utils/widgets/torrent_link_input_field.dart';

class UploadMovieForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> controllers;
  final List<TextEditingController> torrentQualityControllers;
  final List<TextEditingController> torrentUrlControllers;
  final List<TextEditingController> castNameControllers;
  final List<TextEditingController> castImageControllers;
  final VoidCallback onSubmit;
  final bool isLoading;
  final VoidCallback onAddTorrent;
  final Function(int) onRemoveTorrent;
  final VoidCallback onAddCast;
  final Function(int) onRemoveCast;

  const UploadMovieForm({
    super.key,
    required this.formKey,
    required this.controllers,
    required this.torrentQualityControllers,
    required this.torrentUrlControllers,
    required this.castNameControllers,
    required this.castImageControllers,
    required this.onSubmit,
    required this.isLoading,
    required this.onAddTorrent,
    required this.onRemoveTorrent,
    required this.onAddCast,
    required this.onRemoveCast,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomInputField(
            label: "Title",
            icon: FeatherIcons.film,
            controller: controllers[0],
            validator: (v) => Validators.required(v, "Title"),
          ),
          CustomInputField(
            label: "Poster URL",
            icon: FeatherIcons.image,
            controller: controllers[1],
            keyboardType: TextInputType.url,
            validator: (v) => Validators.url(v, "Poster URL"),
          ),
          CustomInputField(
            label: "Banner URL",
            icon: FeatherIcons.image,
            controller: controllers[2],
            keyboardType: TextInputType.url,
            validator: (v) => Validators.url(v, "Banner URL"),
          ),
          CustomInputField(
            label: "Description",
            icon: FeatherIcons.fileText,
            controller: controllers[3],
            maxLines: 3,
            validator: (v) => Validators.required(v, "Description"),
          ),
          CustomInputField(
            label: "Year",
            icon: FeatherIcons.calendar,
            controller: controllers[4],
            keyboardType: TextInputType.number,
            validator: Validators.year,
          ),
          CustomInputField(
            label: "Rating",
            icon: FeatherIcons.star,
            controller: controllers[5],
            keyboardType: TextInputType.number,
            validator: Validators.rating,
          ),
          CustomInputField(
            label: "Genre",
            icon: FeatherIcons.tag,
            controller: controllers[6],
            validator: (v) => Validators.required(v, "Genre"),
          ),
          CustomInputField(
            label: "YouTube Trailer URL",
            icon: FeatherIcons.youtube,
            controller: controllers[7],
            keyboardType: TextInputType.url,
            validator: (v) => Validators.url(v, "Trailer URL"),
          ),
          const SizedBox(height: 28),
          const SectionHeader(icon: Icons.download, title: "Torrent Links"),
          const SizedBox(height: 12),
          ...List.generate(torrentQualityControllers.length, (index) {
            return TorrentLinkInputWidget(
              qualityController: torrentQualityControllers[index],
              urlController: torrentUrlControllers[index],
              onDelete: () => onRemoveTorrent(index),
            );
          }),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onAddTorrent,
              icon: const Icon(Icons.add, color: Colors.deepPurpleAccent),
              label: const Text(
                "Add Torrent",
                style: TextStyle(color: Colors.deepPurpleAccent),
              ),
            ),
          ),
          const SizedBox(height: 28),
          const SectionHeader(icon: Icons.people_alt, title: "Cast Members"),
          const SizedBox(height: 12),
          ...List.generate(castNameControllers.length, (index) {
            return CastInputWidget(
              nameController: castNameControllers[index],
              imageController: castImageControllers[index],
              onSave: () {},
              onDelete: () => onRemoveCast(index),
            );
          }),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onAddCast,
              icon: const Icon(Icons.add, color: Colors.deepPurpleAccent),
              label: const Text(
                "Add Cast",
                style: TextStyle(color: Colors.deepPurpleAccent),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isLoading ? Colors.deepPurple.shade300 : Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: Colors.deepPurple.shade300,
            ),
            icon:
                isLoading
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : const Icon(FeatherIcons.uploadCloud, color: Colors.white),
            label: Text(
              isLoading ? "Uploading..." : "Upload Movie",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            onPressed: isLoading ? null : onSubmit,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
