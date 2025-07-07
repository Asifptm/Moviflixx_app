import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviefliix/theme/theme.dart';
import 'firebase_options.dart'; // Import Firebase options
import 'screens/splash_screen.dart'; // Splash screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // ignore: avoid_print
    print('Firebase initialized successfully');
  } catch (e) {
    // ignore: avoid_print
    print('Failed to initialize Firebase: $e');
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData, // Your app-wide ThemeData
      home: const SplashScreen(), // First screen of the app
    );
  }
}
