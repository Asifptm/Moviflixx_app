import 'package:flutter/material.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ), // Reduced vertical margin
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 72, 72, 88), // Dark purple background
        borderRadius: BorderRadius.circular(8), // Smaller rounded corners
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        leading: Icon(icon, color: Colors.white, size: 20), // Smaller icon size
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16, // Smaller font size
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white70,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}
