import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign In
  Future<User?> signInWithGoogle() async {
    try {
      // begin interactive sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        // User canceled sign-in
        return null;
      } // !!!

      // obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // sign in with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // save user info to Firestore
      await createUserDocument(userCredential);

      return userCredential.user;
    } catch (e) {
      // Handle any errors during sign in
      print("Error signing in with Google: $e");
      return null;
    }
  }

  Future<void> createUserDocument(UserCredential userCredential) async {
    final user = userCredential.user;
    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection("Users").doc(user.email);

      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          "email": user.email,
          "username": user.displayName,
          "photoUrl": user.photoURL,
          "images": [],
        });
      }
    }
  }
}
