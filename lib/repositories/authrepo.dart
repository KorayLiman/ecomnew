import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> SignUp({required String Email, required String Password}) async {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
          email: Email, password: Password);
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        throw Exception("Weak Password");
      } else if (error.code == "email-already-in-use") {
        throw Exception("Email already in use");
      }
    } catch (error) {
      Exception(error.toString());
    }
  }

  Future<void> SignIn({required String Email, required String Password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: Email, password: Password);
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        throw Exception("No user found for this email");
      } else if (error.code == "wrong-password") {
        throw Exception("Wrong password");
      }
    }
  }

  Future<void> SignOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      throw Exception(error);
    }
  }
}
