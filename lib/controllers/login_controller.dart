import 'package:doctorapp/database/firebase_auth.dart';
import 'package:doctorapp/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final authentication = Authentication();

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  Future<void> logincheck() async {
    final email = emailcontroller.text.trim();
    final password = passwordcontroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please Enter All The Fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      User? user = await authentication.login(email, password);

      if (user != null) {
        Get.snackbar("Success", "Login Successful", snackPosition: SnackPosition.BOTTOM);
        emailcontroller.clear();
        passwordcontroller.clear();
        Get.offAll(() => HomePage());
      } else {
        Get.snackbar("Auth Error", "Login Failed", snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", e.message ?? e.code, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.onClose();
  }
}