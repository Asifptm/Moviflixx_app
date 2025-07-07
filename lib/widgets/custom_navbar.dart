import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      // ignore: deprecated_member_use
      backgroundColor: Colors.black.withOpacity(0.35),
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        _buildItem(FontAwesomeIcons.house, 'Home', 0),
        _buildItem(FontAwesomeIcons.list, 'Category', 1),
        _buildItem(FontAwesomeIcons.film, 'Movies', 2),
        _buildItem(FontAwesomeIcons.magnifyingGlass, 'Search', 3),
        _buildItem(FontAwesomeIcons.user, 'Profile', 4),
      ],
    );
  }

  BottomNavigationBarItem _buildItem(IconData icon, String label, int index) {
    final isActive = currentIndex == index;

    return BottomNavigationBarItem(
      label: '',
      icon: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: isActive ? 1.0 : 0.95,
          end: isActive ? 1.2 : 1.05,
        ),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        builder:
            (context, scale, child) => Transform.scale(
              scale: scale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14), // Increased padding
                    decoration:
                        isActive
                            ? BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            )
                            : null,
                    child: FaIcon(
                      icon,
                      color: isActive ? Colors.black : Colors.white70,
                      size: 17, // Increased icon size
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ), // Increased space between icon and text
                  Text(
                    label,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.white54,
                      fontSize: 12, // Increased font size for text
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
