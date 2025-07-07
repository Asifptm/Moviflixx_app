import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up and create user doc at /users/{uid}
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'username': username,
          'isAdmin': false, // Optional UI use only, not for rules
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('A user with this email already exists.');
      } else {
        throw Exception(e.message ?? 'Unknown Firebase Auth error');
      }
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found for that email.');
        case 'wrong-password':
          throw Exception('Wrong password provided for that user.');
        default:
          throw Exception(e.message ?? 'Authentication error');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // 🔐 Check if user is admin (based on token claim)
  Future<bool> isAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final idTokenResult = await user.getIdTokenResult();
    return idTokenResult.claims?['admin'] == true;
  }

  // ✅ Create a movie (admins only)
  Future<void> createMovie({
    required String title,
    required String description,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Not authenticated');
    if (!await isAdmin()) throw Exception('Only admins can add movies.');

    final movieRef = _firestore.collection('movies').doc();
    await movieRef.set({
      'id': movieRef.id,
      'title': title,
      'description': description,
      'ownerId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // ✅ Read a movie (publicly accessible)
  Future<DocumentSnapshot<Map<String, dynamic>>> getMovie(
    String movieId,
  ) async {
    return await _firestore.collection('movies').doc(movieId).get();
  }

  // ✅ Update a movie (admins only)
  Future<void> updateMovie({
    required String movieId,
    required String title,
    required String description,
  }) async {
    if (!await isAdmin()) throw Exception('Only admins can update movies.');
    await _firestore.collection('movies').doc(movieId).update({
      'title': title,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ✅ Delete a movie (admins only)
  Future<void> deleteMovie(String movieId) async {
    if (!await isAdmin()) throw Exception('Only admins can delete movies.');
    await _firestore.collection('movies').doc(movieId).delete();
  }

  // ✅ Update user profile (own profile only)
  Future<void> updateUserProfile({required String username}) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    await _firestore.collection('users').doc(user.uid).update({
      'username': username,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
