import 'package:flutter/material.dart';

class SeriesDatabaseScreen extends StatelessWidget {
  final List<Map<String, String>> seriesList = [
    {
      'title': 'Stranger Things',
      'description': 'A thrilling Netflix original series.',
    },
    {
      'title': 'Breaking Bad',
      'description': 'A high school chemistry teacher turned meth producer.',
    },
    {
      'title': 'The Witcher',
      'description': 'A monster hunter struggles to find his place in a world.',
    },
    // Add more series as needed
  ];

  SeriesDatabaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Series Database')),
      body: ListView.builder(
        itemCount: seriesList.length,
        itemBuilder: (context, index) {
          final series = seriesList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(series['title'] ?? ''),
              subtitle: Text(series['description'] ?? ''),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle series tap (navigate to details, edit, etc.)
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add new series
        },
        tooltip: 'Add Series',
        child: Icon(Icons.add),
      ),
    );
  }
}
