import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // v7: Use singleton instance
  final GoogleSignIn signin = GoogleSignIn.instance;
  final Firestore firestore = Firestore();

  @override
  void onInit() {
    super.onInit();
    // v7: Mandatory initialization
    signin.initialize();
  }

  // 1. Google Sign-In (v7 compatible)
  Future<void> signinwithgoogle() async {
    try {
      final GoogleSignInAccount googleUser = await signin.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await auth.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user == null) throw Exception('Google sign-in failed.');

      await firestore.savessignupdata(
        name: user.displayName ?? '',
        email: user.email ?? googleUser.email,
        phone: user.phoneNumber ?? '',
        uid: user.uid,
      );

      Get.offAll(() => HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // This triggers when the email already exists with a password!
        Get.defaultDialog(
          title: "Account Exists",
          middleText:
          "An account with this email already exists with a password. Please sign in with your email & password first to link Google.",
          textConfirm: "OK",
          onConfirm: () => Get.back(),
        );
      } else {
        Get.snackbar('Google Sign-In Error', e.message ?? e.code);
      }
    } catch (e) {
      Get.snackbar('Error', 'Unable to sign in. Please try again.');
    }
  }

  // 2. Link Email/Password to current Google account
  Future<void> linkEmailPassword(String password) async {
    try {
      final User? user = auth.currentUser;

      if (user == null || user.email == null) {
        Get.snackbar('Error', 'Please sign in first.');
        return;
      }

      // Check if password provider is already attached
      final bool alreadyHasPassword = user.providerData.any(
            (provider) => provider.providerId == 'password',
      );

      if (alreadyHasPassword) {
        await user.updatePassword(password);
        Get.snackbar('Success', 'Password updated for this account.');
        return;
      }

      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      // Link credential to make both Google & Password share the same UID
      final UserCredential result = await user.linkWithCredential(credential);
      await result.user?.reload();

      Get.snackbar(
        'Success',
        'Password linked! You can now log in with either Google or Email/Password.',
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Link Error',
        e.message ?? e.code,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unable to link email/password.',
      );
    }
  }

  // 3. Password Dialog
  void showPasswordDialog() {
    final TextEditingController passwordController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Set Account Password'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'New password',
            hintText: 'At least 6 characters',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              passwordController.dispose();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final String password = passwordController.text.trim();
              if (password.length < 6) {
                Get.snackbar('Invalid Password', 'Enter at least 6 characters.');
                return;
              }

              Get.back();
              passwordController.dispose();

              await linkEmailPassword(password);
            },
            child: const Text('Set Password'),
          ),
        ],
      ),
    );
  }
}