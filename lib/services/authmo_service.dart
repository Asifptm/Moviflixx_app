import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MovieService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<QueryDocumentSnapshot>> fetchNewMovies({
    required bool isAdmin,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final query =
        isAdmin
            ? _firestore
                .collection('movies')
                .orderBy('createdAt', descending: true)
            : _firestore
                .collection('movies')
                .where('uid', isEqualTo: user.uid)
                .orderBy('createdAt', descending: true);

    final snapshot = await query.get();
    return snapshot.docs;
  }
}
