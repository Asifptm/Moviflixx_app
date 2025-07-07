import 'package:flutter/material.dart';

/// A reusable wrapper to provide pull-to-refresh functionality
class RefreshWrapper extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const RefreshWrapper({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      displacement: 40,
      edgeOffset: 16,
      child: child,
    );
  }
}
