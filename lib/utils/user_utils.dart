import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserUtils {
  static Future<Map<String, dynamic>?> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    if (username == null) return null;

    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: username)
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
      } else {
        return {'username': username, 'email': 'Not found'};
      }
    } catch (e) {
      return {'username': username, 'email': 'Error loading data'};
    }
  }

  static Future<void> updateAvatar(String path) async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');

    if (username == null) return;

    final query =
        await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username)
            .limit(1)
            .get();

    if (query.docs.isNotEmpty) {
      final docId = query.docs.first.id;
      await FirebaseFirestore.instance.collection('users').doc(docId).update({
        'avatar': path,
      });
    }
  }
}
