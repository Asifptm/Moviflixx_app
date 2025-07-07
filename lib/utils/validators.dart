class Validators {
  static String? required(String? value, [String field = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? url(String? value, [String field = 'URL']) {
    final uri = Uri.tryParse(value ?? '');
    if (uri == null || !(uri.hasAbsolutePath || uri.hasScheme)) {
      return 'Enter a valid $field';
    }
    return null;
  }

  static String? year(String? value) {
    if (value == null || value.trim().isEmpty) return 'Year is required';
    final year = int.tryParse(value);
    if (year == null || year < 1888 || year > DateTime.now().year + 1) {
      return 'Enter a valid year';
    }
    return null;
  }

  static String? rating(String? value) {
    if (value == null || value.trim().isEmpty) return 'Rating is required';
    final rating = double.tryParse(value);
    if (rating == null || rating < 0 || rating > 10) {
      return 'Enter a rating between 0 and 10';
    }
    return null;
  }

  static String? youtubeIframe(String? value) {
    if (value == null || value.trim().isEmpty) return null; // optional field

    final trimmedValue = value.trim();

    final lowerValue = trimmedValue.toLowerCase();

    if (!lowerValue.startsWith('<iframe') ||
        !lowerValue.endsWith('</iframe>')) {
      return 'Please enter a valid iframe embed code';
    }

    final srcRegex = RegExp(r'src="([^"]+)"');
    final match = srcRegex.firstMatch(trimmedValue);
    if (match == null) {
      return 'iframe must include a src attribute';
    }

    final srcUrl = match.group(1)!;

    final ytEmbedRegex = RegExp(
      r'^https:\/\/www\.youtube\.com\/embed\/[a-zA-Z0-9_-]+(\?[^\s"]+)?$',
    );

    if (!ytEmbedRegex.hasMatch(srcUrl)) {
      return 'Invalid YouTube embed src URL';
    }

    return null;
  }
}
