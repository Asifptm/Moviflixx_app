import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set black background color
      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: Colors.black,
      ),
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        children: [
          _buildCategoryCard("Action", Icons.movie),
          _buildCategoryCard("Comedy", Icons.emoji_emotions),
          _buildCategoryCard("Drama", Icons.theater_comedy),
          _buildCategoryCard("Horror", Icons.warning),
          _buildCategoryCard("Romance", Icons.favorite),
          _buildCategoryCard("Sci-Fi", Icons.science),
          _buildCategoryCard("Hollywood", Icons.local_movies),
          _buildCategoryCard("Mollywood", Icons.movie_creation),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Handle category tap
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
