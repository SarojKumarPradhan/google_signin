import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController {
  User? user = FirebaseAuth.instance.currentUser;

   Future<User?> loginWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();
    final googleAuth = await googleAccount?.authentication;

//sign in with firebase auth
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    return userCredential.user;
  }

   Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
