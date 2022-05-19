import 'package:ecomappkoray/modals/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AppUser?> CreateUserWithEmailAndPassword(
      String Email, String Password) async {
    UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: Email, password: Password);
    return await UserFromFirebase(credential.user);
  }

  Future<AppUser?> CurrentUser() async {
    try {
      User? user = await _firebaseAuth.currentUser;
      return UserFromFirebase(user);
    } catch (error) {
      print("Current User Error" + error.toString());
      return null;
    }
  }

  Future<AppUser?> UserFromFirebase(User? user) async {
    if (user == null) {
      return null;
    } else {
      return AppUser(UserID: user.uid, IsAdmin: false, Email: user.email!);
    }
  }

  Future<bool> SignOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (error) {
      print("Sign out Error" + error.toString());
      return false;
    }
  }

  Future<AppUser?> SignInWithEmailAndPassword(
      String Email, String Password) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: Email, password: Password);
    return await UserFromFirebase(credential.user);
  }

  Future<bool> DeleteAccount() async {
    try {
      _firebaseAuth.currentUser!.delete();
      return true;
    } catch (error) {
      print("Delete Account Error" + error.toString());
      return false;
    }
  }
}
