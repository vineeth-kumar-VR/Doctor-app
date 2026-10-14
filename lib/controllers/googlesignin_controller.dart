import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/pages/homepage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn signin = GoogleSignIn.instance;
  final firestore = Firestore();

  @override
  void onInit() {
    super.onInit();
    signin.initialize();
  }
  Future<void> signinwithgoogle() async {
    try {
      // Open Google Sign-In
      final GoogleSignInAccount googleuser =
      await signin.authenticate();

      final GoogleSignInAuthentication googleauth =
          googleuser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleauth.idToken,
      );

      final String googleEmail = googleuser.email;

      print("Google Email: $googleEmail");

      // Check whether the email exists in Firestore
      final bool emailExists =
      await firestore.checkGoogleEmail(googleEmail);

      if (!emailExists) {
        Get.snackbar(
          "Google Sign-In",
          "This Google account is not registered. Please sign up first.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Google is already linked to this Firebase account.
      // So sign in normally using the Google credential.
      final UserCredential userCredential =
      await auth.signInWithCredential(credential);

      print("Google Sign-In successful");
      print("Firebase UID: ${userCredential.user?.uid}");

      Get.offAll(() => HomePage());

    } on FirebaseAuthException catch (e) {
      print("Firebase Google Error: ${e.code}");
      print(e.message);

      Get.snackbar(
        "Google Sign-In",
        e.message ?? "Google Sign-In failed",
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }
}