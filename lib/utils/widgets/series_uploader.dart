import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:moviefliix/utils/cast_input_widget.dart';
import 'package:moviefliix/utils/episode_input.dart';
import 'package:moviefliix/utils/inputs.dart';
import 'package:moviefliix/utils/validators.dart';
import 'package:moviefliix/utils/widgets/section_header.dart';

class UploadSeriesForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<TextEditingController> controllers;

  final List<TextEditingController> castNameControllers;
  final List<TextEditingController> castImageControllers;

  final List<TextEditingController> episodeTitleControllers;
  final List<TextEditingController> episodeNumberControllers;
  final List<List<TextEditingController>> episodeTorrentQualityControllers;
  final List<List<TextEditingController>> episodeTorrentUrlControllers;

  final VoidCallback onSubmit;
  final bool isLoading;

  final VoidCallback onAddCast;
  final Function(int) onRemoveCast;

  final VoidCallback onAddEpisode;
  final Function(int) onRemoveEpisode;

  const UploadSeriesForm({
    super.key,
    required this.formKey,
    required this.controllers,
    required this.castNameControllers,
    required this.castImageControllers,
    required this.episodeTitleControllers,
    required this.episodeNumberControllers,
    required this.episodeTorrentQualityControllers,
    required this.episodeTorrentUrlControllers,
    required this.onSubmit,
    required this.isLoading,
    required this.onAddCast,
    required this.onRemoveCast,
    required this.onAddEpisode,
    required this.onRemoveEpisode,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomInputField(
            label: "Title",
            icon: FeatherIcons.tv,
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
            label: "Trailer URL",
            icon: FeatherIcons.youtube,
            controller: controllers[7],
            keyboardType: TextInputType.url,
            validator: (v) => Validators.url(v, "Trailer URL"),
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

          const SizedBox(height: 28),
          const SectionHeader(icon: Icons.list, title: "Episodes"),
          const SizedBox(height: 12),

          ...List.generate(episodeTitleControllers.length, (index) {
            return EpisodeInputWidget(
              episodeIndex: index,
              titleController: episodeTitleControllers[index],
              numberController: episodeNumberControllers[index],
              torrentQualityControllers:
                  episodeTorrentQualityControllers[index],
              torrentUrlControllers: episodeTorrentUrlControllers[index],
              onRemoveEpisode: () => onRemoveEpisode(index),
            );
          }),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onAddEpisode,
              icon: const Icon(Icons.add, color: Colors.deepPurpleAccent),
              label: const Text(
                "Add Episode",
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
              isLoading ? "Uploading..." : "Upload Series",
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
