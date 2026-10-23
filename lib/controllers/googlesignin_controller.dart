
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn signin = GoogleSignIn.instance;
  final Firestore firestore = Firestore();

  @override
  void onInit() {
    super.onInit();
    signin.initialize();
  }

  // Google Sign-In
  Future<void> signinwithgoogle() async {
    try {
      final GoogleSignInAccount googleUser =
      await signin.authenticate();

      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Google sign-in failed.');
      }

      final String email = user.email ?? googleUser.email;

      print('Google Email: $email');
      print('Firebase UID: ${user.uid}');

      await firestore.savessignupdata(
        name: user.displayName ?? '',
        email: email,
        phone: user.phoneNumber ?? '',
        uid: user.uid,
      );

      Get.offAll(() => HomePage());
    } on FirebaseAuthException catch (e) {
      print('Google sign-in error: ${e.code}');
      print('Message: ${e.message}');

      Get.snackbar(
        'Google Sign-In Error',
        e.message ?? e.code,
      );
    } catch (e) {
      print('Google sign-in error: $e');

      Get.snackbar(
        'Google Sign-In Error',
        'Unable to sign in. Please try again.',
      );
    }
  }

  // Link email/password to the currently signed-in Google account
  Future<void> linkEmailPassword(String password) async {
    try {
      final User? user = auth.currentUser;

      if (user == null || user.email == null) {
        Get.snackbar(
          'Error',
          'Please sign in with Google first.',
        );
        return;
      }

      // Avoid linking twice
      final bool alreadyLinked = user.providerData.any(
            (provider) => provider.providerId == 'password',
      );

      if (alreadyLinked) {
        Get.snackbar(
          'Already linked',
          'Email/password is already linked to this account.',
        );
        return;
      }

      final AuthCredential credential =
      EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      final UserCredential result =
      await user.linkWithCredential(credential);

      await result.user?.reload();

      final User? updatedUser = auth.currentUser;

      print(
        'Providers: ${updatedUser?.providerData.map((p) => p.providerId).toList()}',
      );

      Get.snackbar(
        'Success',
        'Email/password linked to your Google account.',
      );
    } on FirebaseAuthException catch (e) {
      print('Link error: ${e.code}');
      print('Message: ${e.message}');

      Get.snackbar(
        'Link Error',
        '${e.code}: ${e.message ?? 'Unable to link account'}',
      );
    } catch (e) {
      print('Unexpected link error: $e');

      Get.snackbar(
        'Error',
        'Unable to link email/password.',
      );
    }
  }

  // Show a password dialog only when the user chooses to set a password
  void showPasswordDialog() {
    final TextEditingController passwordController =
    TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Set Email Password'),
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
              final String password =
                  passwordController.text;

              if (password.length < 6) {
                Get.snackbar(
                  'Invalid Password',
                  'Enter at least 6 characters.',
                );
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
