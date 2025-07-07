import 'package:flutter/material.dart';
import 'package:moviefliix/utils/helper_form.dart';
import 'package:moviefliix/utils/upload_form.dart';

class UploadMovieScreen extends StatefulWidget {
  const UploadMovieScreen({super.key});

  @override
  State<UploadMovieScreen> createState() => _UploadMovieScreenState();
}

class _UploadMovieScreenState extends State<UploadMovieScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final posterUrlController = TextEditingController();
  final bannerUrlController = TextEditingController();
  final descriptionController = TextEditingController();
  final yearController = TextEditingController();
  final ratingController = TextEditingController();
  final genreController = TextEditingController();
  final trailerUrlController = TextEditingController();

  final List<TextEditingController> torrentQualityControllers = [];
  final List<TextEditingController> torrentUrlControllers = [];

  final List<TextEditingController> castNameControllers = [];
  final List<TextEditingController> castImageControllers = [];
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

    for (final c in torrentQualityControllers) {
      c.dispose();
    }
    for (final c in torrentUrlControllers) {
      c.dispose();
    }

    for (final c in castNameControllers) {
      c.dispose();
    }
    for (final c in castImageControllers) {
      c.dispose();
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

  void _addTorrentField() {
    setState(() {
      torrentQualityControllers.add(TextEditingController());
      torrentUrlControllers.add(TextEditingController());
    });
  }

  void _removeTorrentField(int index) {
    setState(() {
      torrentQualityControllers[index].dispose();
      torrentUrlControllers[index].dispose();
      torrentQualityControllers.removeAt(index);
      torrentUrlControllers.removeAt(index);
    });
  }

  void _submitForm() async {
    setState(() => _isLoading = true);

    await MovieFormHelper.submitMovieForm(
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
      torrentQualityControllers: torrentQualityControllers,
      torrentUrlControllers: torrentUrlControllers,
      castNameControllers: castNameControllers,
      castImageControllers: castImageControllers,
    );

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          "Upload Movie",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: UploadMovieForm(
          formKey: _formKey,
          controllers: [
            titleController,
            posterUrlController,
            bannerUrlController,
            descriptionController,
            yearController,
            ratingController,
            genreController,
            trailerUrlController,
          ],
          torrentQualityControllers: torrentQualityControllers,
          torrentUrlControllers: torrentUrlControllers,
          castNameControllers: castNameControllers,
          castImageControllers: castImageControllers,
          isLoading: _isLoading,
          onSubmit: _submitForm,
          onAddTorrent: _addTorrentField,
          onRemoveTorrent: _removeTorrentField,
          onAddCast: _addCastField,
          onRemoveCast: _removeCastField,
        ),
      ),
    );
  }
}
