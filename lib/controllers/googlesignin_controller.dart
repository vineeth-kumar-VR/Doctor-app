import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn signin = GoogleSignIn.instance;

  @override
  void onInit() {
    super.onInit();
    signin.initialize();
  }

  Future<void> signinwithgoogle() async {
    try {
      final GoogleSignInAccount googleUser = await signin.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 1. Sign in with Google
      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user == null) throw Exception('Google sign-in failed.');

      // 2. Search Firestore to see if this user previously registered with a password
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        final String? savedPassword = data['password'];

        // If a password was saved, re-attach it to Firebase Auth in the background!
        if (savedPassword != null && savedPassword.isNotEmpty) {
          try {
            await user.updatePassword(savedPassword);
            await user.reload();
          } catch (_) {
            // Silently continue if already attached
          }
        }
      } else {
        // First-time Google user: save their info
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName ?? '',
          'email': user.email ?? googleUser.email,
          'phone': user.phoneNumber ?? '',
          'uid': user.uid,
        }, SetOptions(merge: true));
      }

      // 3. Directly navigate to HomePage - NO forms, NO popups!
      Get.offAll(() => HomePage());

    } on FirebaseAuthException catch (e) {
      Get.snackbar('Google Sign-In Error', e.message ?? e.code);
    } catch (e) {
      Get.snackbar('Error', 'Unable to sign in. Please try again.');
    }
  }
}