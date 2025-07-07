import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AdminAuthService(this._auth, this._firestore);

  Future<User?> registerAdmin(
    String email,
    String password,
    String username,
  ) async {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);

    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'username': username, // 👈 store the username
      'isAdmin': true,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return userCredential.user;
  }

  Future<User?> loginAdmin(String email, String password) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);

    final doc =
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

    if (doc.exists && doc.data()!['isAdmin'] == true) {
      return userCredential.user;
    } else {
      throw FirebaseAuthException(
        code: 'not-admin',
        message: 'This user is not an admin.',
      );
    }
  }

  Future<void> logout() async => await _auth.signOut();

  User? get currentUser => _auth.currentUser;
}
