import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:moviefliix/utils/cast_input_widget.dart';
import 'package:moviefliix/utils/episode_input.dart';
import 'package:moviefliix/utils/inputs.dart';
import 'package:moviefliix/utils/validators.dart';
import 'package:moviefliix/utils/widgets/epidata.dart';
import 'package:moviefliix/utils/widgets/section_header.dart';
import 'package:moviefliix/utils/widgets/series_helper.dart';

class UploadSeriesScreen extends StatefulWidget {
  const UploadSeriesScreen({super.key});

  @override
  State<UploadSeriesScreen> createState() => _UploadSeriesScreenState();
}

class _UploadSeriesScreenState extends State<UploadSeriesScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final posterUrlController = TextEditingController();
  final bannerUrlController = TextEditingController();
  final descriptionController = TextEditingController();
  final yearController = TextEditingController();
  final ratingController = TextEditingController();
  final genreController = TextEditingController();
  final trailerUrlController = TextEditingController();

  final List<TextEditingController> castNameControllers = [];
  final List<TextEditingController> castImageControllers = [];

  final List<EpisodeInputData> episodes = [];
  bool _isLoading = false;

  @override
  void dispose() {
    titleController.dispose();
    posterUrlController.dispose();
    bannerUrlController.dispose();
    descriptionController.dispose();
    yearController.dispose();
    ratingController.dispose();
    genreController.dispose();
    trailerUrlController.dispose();

    for (final c in castNameControllers) {
      c.dispose();
    }
    for (final c in castImageControllers) {
      c.dispose();
    }

    for (final e in episodes) {
      e.dispose(); // 🔁 use the dispose() from EpisodeInputData
    }

    super.dispose();
  }

  void _addCastField() {
    setState(() {
      castNameControllers.add(TextEditingController());
      castImageControllers.add(TextEditingController());
    });
  }

  void _removeCastField(int index) {
    setState(() {
      castNameControllers[index].dispose();
      castImageControllers[index].dispose();
      castNameControllers.removeAt(index);
      castImageControllers.removeAt(index);
    });
  }

  void _addEpisodeField() {
    setState(() {
      episodes.add(EpisodeInputData());
    });
  }

  void _removeEpisodeField(int index) {
    setState(() {
      episodes[index].dispose();
      episodes.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await SeriesFormHelper.submitSeriesForm(
        context: context,
        formKey: _formKey,
        titleController: titleController,
        posterUrlController: posterUrlController,
        bannerUrlController: bannerUrlController,
        descriptionController: descriptionController,
        yearController: yearController,
        ratingController: ratingController,
        genreController: genreController,
        trailerUrlController: trailerUrlController,
        castNameControllers: castNameControllers,
        castImageControllers: castImageControllers,
        episodes: episodes,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          "Upload Series",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInputField(
                label: "Title",
                icon: FeatherIcons.film,
                controller: titleController,
                validator: (v) => Validators.required(v, "Title"),
              ),
              CustomInputField(
                label: "Poster URL",
                icon: FeatherIcons.image,
                controller: posterUrlController,
                validator: (v) => Validators.url(v, "Poster URL"),
              ),
              CustomInputField(
                label: "Banner URL",
                icon: FeatherIcons.image,
                controller: bannerUrlController,
                validator: (v) => Validators.url(v, "Banner URL"),
              ),
              CustomInputField(
                label: "Description",
                icon: FeatherIcons.fileText,
                controller: descriptionController,
                maxLines: 3,
                validator: (v) => Validators.required(v, "Description"),
              ),
              CustomInputField(
                label: "Year",
                icon: FeatherIcons.calendar,
                controller: yearController,
                keyboardType: TextInputType.number,
                validator: Validators.year,
              ),
              CustomInputField(
                label: "Rating",
                icon: FeatherIcons.star,
                controller: ratingController,
                keyboardType: TextInputType.number,
                validator: Validators.rating,
              ),
              CustomInputField(
                label: "Genre",
                icon: FeatherIcons.tag,
                controller: genreController,
                validator: (v) => Validators.required(v, "Genre"),
              ),
              CustomInputField(
                label: "Trailer URL",
                icon: FeatherIcons.youtube,
                controller: trailerUrlController,
                keyboardType: TextInputType.url,
                validator: (v) => Validators.url(v, "Trailer URL"),
              ),

              const SizedBox(height: 28),
              const SectionHeader(icon: Icons.tv, title: "Episodes"),
              const SizedBox(height: 12),

              ...List.generate(episodes.length, (index) {
                final ep = episodes[index];
                return EpisodeInputWidget(
                  episodeIndex: index,
                  titleController: ep.titleController,
                  numberController: ep.episodeNumberController,
                  torrentQualityControllers: ep.torrentQualityControllers,
                  torrentUrlControllers: ep.torrentUrlControllers,
                  onRemoveEpisode: () => _removeEpisodeField(index),
                );
              }),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _addEpisodeField,
                  icon: const Icon(Icons.add, color: Colors.deepPurpleAccent),
                  label: const Text(
                    "Add Episode",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),

              const SizedBox(height: 28),
              const SectionHeader(
                icon: Icons.people_alt,
                title: "Cast Members",
              ),
              const SizedBox(height: 12),

              ...List.generate(castNameControllers.length, (index) {
                return CastInputWidget(
                  nameController: castNameControllers[index],
                  imageController: castImageControllers[index],
                  onDelete: () => _removeCastField(index),
                  onSave: () {}, // placeholder if needed
                );
              }),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _addCastField,
                  icon: const Icon(Icons.add, color: Colors.deepPurpleAccent),
                  label: const Text(
                    "Add Cast",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _submitForm,
                icon:
                    _isLoading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : const Icon(
                          FeatherIcons.uploadCloud,
                          color: Colors.white,
                        ),
                label: Text(_isLoading ? "Uploading..." : "Upload Series"),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isLoading
                          ? Colors.deepPurple.shade300
                          : Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.deepPurple.shade300,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
