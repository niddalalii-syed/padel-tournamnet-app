import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null; // cancelled

    // Get the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('idToken', googleAuth.idToken.toString());
    await prefs.setString('accessToken', googleAuth.accessToken.toString());

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Store the Google user ID in shared preferences
    await prefs.setString('googleUserId', googleUser.id);
    await prefs.setBool("isloggedIn", true);

    // Sign in to Firebase with the Google user credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    print('Google Sign-In Error: $e');
    return null;
  }
}
