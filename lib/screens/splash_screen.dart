import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:moviefliix/screens/home_screen.dart';
import 'package:moviefliix/screens/index_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showSpinner = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showSpinner = true;
        });

        // Delay, then check login status
        Timer(const Duration(seconds: 3), _checkLoginStatus);
      }
    });
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('loggedIn') ?? false;
    // ignore: unused_local_variable
    final username = prefs.getString('username') ?? '';

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder:
            (_, __, ___) => loggedIn ? ProfileScreen() : const IndexScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.deepPurple,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset('assets/images/logo.png', width: 270),
                    ),
                    if (_showSpinner) const SizedBox(height: 60),
                    if (_showSpinner)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        FeatherIcons.instagram,
                        color: Colors.white,
                        size: 22,
                      ),
                      SizedBox(width: 20),
                      Icon(FeatherIcons.twitter, color: Colors.white, size: 22),
                      SizedBox(width: 20),
                      Icon(
                        FeatherIcons.facebook,
                        color: Colors.white,
                        size: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '© 2025 MoviFLix. All rights reserved.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
