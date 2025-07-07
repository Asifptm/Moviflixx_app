// reusable_scrollable_filter.dart
import 'package:flutter/material.dart';

class ScrollableFilterBar extends StatelessWidget {
  final List<String> filters;
  final String selectedFilter;
  final Function(String) onSelected;

  const ScrollableFilterBar({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = filters[index] == selectedFilter;

          return GestureDetector(
            onTap: () => onSelected(filters[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.grey[800],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white12, width: 1),
              ),
              child: Text(
                filters[index],
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
