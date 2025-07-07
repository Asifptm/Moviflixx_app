import 'package:flutter/material.dart';

class ImagePreviewField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const ImagePreviewField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
  });

  @override
  State<ImagePreviewField> createState() => _ImagePreviewFieldState();
}

class _ImagePreviewFieldState extends State<ImagePreviewField> {
  String? _previewUrl;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updatePreview);
  }

  void _updatePreview() {
    final url = widget.controller.text.trim();
    if (url != _previewUrl) {
      setState(() {
        _previewUrl = url;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updatePreview);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white24),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[850],
          ),
          validator: widget.validator,
        ),
        const SizedBox(height: 8),
        if (_previewUrl != null && _previewUrl!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _previewUrl!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'Could not load image',
                  style: TextStyle(color: Colors.redAccent),
                );
              },
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}
