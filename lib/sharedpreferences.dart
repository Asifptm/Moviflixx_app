import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  // Save data
  Future<void> saveUserData({
    required bool loggedIn,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', loggedIn);
    await prefs.setString('username', username);
  }

  // Get data
  Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('loggedIn') ?? false;
    final username = prefs.getString('username') ?? '';
    return {'loggedIn': loggedIn, 'username': username};
  }

  // Remove data (Logout)
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedIn');
    await prefs.remove('username');
  }
}
