import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final IconData? icon;
  final bool isRequired;

  const CustomInputField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.icon,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(
            children: [
              if (icon != null)
                Icon(icon, size: 18, color: Colors.deepPurpleAccent),
              if (icon != null) const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              if (isRequired)
                const Text(" *", style: TextStyle(color: Colors.red)),
            ],
          ),
        ),

        // TextFormField with validation
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: Colors.white10,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.deepPurpleAccent,
                width: 1.5,
              ),
            ),
            errorStyle: const TextStyle(color: Colors.redAccent),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
