import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/auth_pages/login.dart';
import 'package:doctorapp/database/firebase_auth.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final firestore = Firestore();
  final authentication = Authentication();

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController conpasswordcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();

  Future<void> signup() async {
    final name = namecontroller.text.trim();
    final email = emailcontroller.text.trim();
    final password = passwordcontroller.text.trim();
    final conPassword = conpasswordcontroller.text.trim();
    final phone = phonecontroller.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || conPassword.isEmpty || phone.isEmpty) {
      Get.snackbar("Error", "Please Enter All The Fields", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (password != conPassword) {
      Get.snackbar("Password Error", "Passwords do not match", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      User? user = await authentication.signupwithemailandpassword(email, password);

      if (user != null) {
        // 1. Save profile to Firestore including the password
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'uid': user.uid,
          'password': password, // Stored to automatically restore if Google strips it
        });

        // 2. Sign out so user starts fresh on the Login page
        await FirebaseAuth.instance.signOut();

        namecontroller.clear();
        emailcontroller.clear();
        passwordcontroller.clear();
        conpasswordcontroller.clear();
        phonecontroller.clear();

        Get.snackbar(
          "Success",
          "Signup Successful",
          backgroundColor: Colors.white,
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAll(() => const LoginPage());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    conpasswordcontroller.dispose();
    phonecontroller.dispose();
    super.onClose();
  }
}