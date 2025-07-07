import 'package:flutter/material.dart';
import 'package:moviefliix/screens/optionscreens/notifications_screen.dart';
import 'package:moviefliix/screens/optionscreens/privacy_settings_screen.dart';
import 'package:moviefliix/screens/optionscreens/recommend_screen.dart';
import 'package:moviefliix/screens/optionscreens/settings_screen.dart';
import 'package:moviefliix/screens/optionscreens/versionapp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviefliix/utils/avatar_picker.dart';
import 'package:moviefliix/screens/login_screen.dart';
import 'package:moviefliix/utils/user_utils.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:moviefliix/widgets/ui/profile_option_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _email = '';
  String _avatar = 'assets/images/avatar/male2.jpg';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await UserUtils.fetchUserData();

    if (!mounted) return;

    if (data == null) {
      setState(() => _loading = false);
    } else {
      setState(() {
        _username = data['username'] ?? 'Unknown';
        _email = data['email'] ?? 'No email';
        _avatar = data['avatar'] ?? 'assets/images/avatar/male2.jpg';
        _loading = false;
      });
    }
  }

  Future<void> _handleAvatarChange(String path) async {
    setState(() {
      _avatar = path;
    });
    await UserUtils.updateAvatar(path);
  }

  Future<void> _signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedIn');
    await prefs.remove('username');

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _navigateWithTransition(Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, __, ___) => screen,
        transitionsBuilder: (_, animation, __, child) {
          final tween = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1E2C), Color(0xFF23233D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child:
            _loading
                ? const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 90, 70, 163),
                  ),
                )
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(_avatar),
                            backgroundColor: Colors.grey.shade800,
                          ),
                          GestureDetector(
                            onTap: () {
                              showAvatarPicker(
                                context,
                                onAvatarSelected: _handleAvatarChange,
                              );
                            },
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _username,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          ProfileOptionTile(
                            icon: FeatherIcons.sliders,
                            title: 'Settings',
                            onTap:
                                () => _navigateWithTransition(
                                  const SettingsScreen(),
                                ),
                          ),
                          const Divider(
                            color: Colors.white30, // Subtle divider color
                            thickness: 1, // Thin divider
                            indent: 16, // Padding for divider's start
                            endIndent: 16, // Padding for divider's end
                          ),
                          ProfileOptionTile(
                            icon: FeatherIcons.star,
                            title: 'Recommendations',
                            onTap:
                                () => _navigateWithTransition(
                                  const RecommendScreen(),
                                ),
                          ),
                          const Divider(
                            color: Colors.white30,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                          ProfileOptionTile(
                            icon: FeatherIcons.key,
                            title: 'Change Password',
                            onTap:
                                () => _navigateWithTransition(
                                  const VersionAppScreen(),
                                ),
                          ),
                          const Divider(
                            color: Colors.white30,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                          ProfileOptionTile(
                            icon: FeatherIcons.lock,
                            title: 'Privacy Settings',
                            onTap:
                                () => _navigateWithTransition(
                                  const PrivacySettingsScreen(),
                                ),
                          ),
                          const Divider(
                            color: Colors.white30,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                          ProfileOptionTile(
                            icon: FeatherIcons.bell,
                            title: 'Notifications',
                            onTap:
                                () => _navigateWithTransition(
                                  const NotificationsScreen(),
                                ),
                          ),
                          const Divider(
                            color: Colors.white30,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                          ProfileOptionTile(
                            icon: FeatherIcons.info,
                            title: 'About',
                            onTap: () {
                              // Handle About section
                            },
                          ),
                          const Divider(
                            color: Colors.white30,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
