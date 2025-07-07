import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:moviefliix/screens/admin/widgets/database_tab.dart';
import 'package:moviefliix/screens/admin/widgets/seires_tab.dart';

class MoviePageScreen extends StatelessWidget {
  const MoviePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two main tabs: Upload & Database
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(246, 24, 24, 24),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.movie_filter_outlined, color: Colors.deepPurpleAccent),
              SizedBox(width: 8),
              Text(
                "Admin Movie Panel",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.deepPurpleAccent,
            labelColor: Colors.deepPurpleAccent,
            unselectedLabelColor: Colors.white54,
            tabs: [
              Tab(icon: Icon(FeatherIcons.upload), text: "Upload"),
              Tab(icon: Icon(FeatherIcons.folder), text: "Database"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [UploadTabSection(), DatabaseTabSection()],
        ),
      ),
    );
  }
}
