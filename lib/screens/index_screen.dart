import 'package:flutter/material.dart';
import 'package:moviefliix/screens/sign_up_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/2.jpg',
      'title': 'Unlimited entertainment,\none low price.',
      'subtitle': 'All of Netflix, starting at just ₹149.',
      'button': 'GET STARTED',
    },
    {
      'image': 'assets/images/4.jpg',
      'title': 'Watch anywhere,\nCancel anytime.',
      'subtitle': 'Enjoy on your phone, tablet, or TV.',
      'button': 'NEXT',
    },
    {
      'image': 'assets/images/3.jpg',
      'title': 'Watch anywhere,\nCancel anytime.',
      'subtitle': 'Enjoy on your phone, tablet, or TV.',
      'button': 'NEXT',
    },
    {
      'image': 'assets/images/7.jpg',
      'title': 'Ready to watch?',
      'subtitle': 'Create an account to get started.',
      'button': 'SIGN UP',
    },
  ];

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      // Navigate to the Sign Up screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignUpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = pages[_currentPage];

    return Scaffold(
      body: Stack(
        children: [
          // Background image aligned to the top
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: SizedBox.expand(
              key: ValueKey<String>(page['image']!),
              child: Container(
                alignment: Alignment.topCenter,
                color: Colors.black, // fallback background color
                child: Image.asset(
                  page['image']!,
                  fit: BoxFit.fitWidth, // Maintain width, preserve aspect ratio
                ),
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color.fromARGB(206, 0, 0, 0),
                  Colors.black,
                ],
              ),
            ),
          ),

          // Content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Title animation
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Text(
                      page['title']!,
                      key: ValueKey<String>(page['title']!),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Subtitle animation
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Text(
                      page['subtitle']!,
                      key: ValueKey<String>(page['subtitle']!),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(pages.length, (index) {
                      bool isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 12 : 8,
                        height: isActive ? 12 : 8,
                        decoration: BoxDecoration(
                          color: isActive ? Colors.white : Colors.white38,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 32),

                  // Full-width button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color.fromARGB(255, 55, 53, 163),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        page['button']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
