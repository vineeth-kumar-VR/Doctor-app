import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/auth_pages/login.dart';
import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firebase_auth.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController{
  final firestore = Firestore();
  final authentication = Authentication();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController conpasswordcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();


  Future<void>signup()async {
    if (namecontroller.text
        .trim()
        .isEmpty || emailcontroller.text
        .trim()
        .isEmpty || passwordcontroller.text
        .trim()
        .isEmpty || conpasswordcontroller.text
        .trim()
        .isEmpty || phonecontroller.text
        .trim()
        .isEmpty) {
      Get.snackbar(
          borderRadius: 10,
          backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          snackPosition: SnackPosition.BOTTOM,
          "Error", "Please Enter All The Fields");
      return;
    }
    String password = passwordcontroller.text.trim();
    if(password.length < 8){
      Get.snackbar("Weak Password", "Password must contain at least 8 characters",
      borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM
      );
      return;
    }
    if(!RegExp(r'[A-Z]').hasMatch(password)){
      Get.snackbar("Weak Password",
        "Password must contain at least one uppercase letter",
      borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM
      );
      return;
    }
    if(!RegExp(r'[a-z]').hasMatch(password)){
      Get.snackbar("Weak Password",
          "Password must contain at least one uppercase letter",
          borderRadius: 10,
          snackPosition: SnackPosition.BOTTOM
      );
      return;

    }
    if(!RegExp(r'[0-9]').hasMatch(password)){
      Get.snackbar(
        "Weak Password",
        "Password must contain at least one number",
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }
    if(RegExp(r'[!@#$%^&*(),.?":{}|<>]]').hasMatch(password)){
      Get.snackbar(
        "Weak Password",
        "Password must contain at least one special character",
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }
    if(passwordcontroller.text != conpasswordcontroller.text){
      Get.snackbar(
        "Password Error",
        "Passwords do not match",
        borderRadius: 10,
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }
    User? user = await authentication.signupwithemailandpassword(
        emailcontroller.text, passwordcontroller.text);
    if (user != null) {
      try {
        await firestore.savessignupdata(name: namecontroller.text,
            email: emailcontroller.text,
            phone: phonecontroller.text,
            uid: user.uid);
        Get.snackbar(
            borderRadius: 10,
            backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,

            "Success", "SignUp Success");
        namecontroller.clear();
        emailcontroller.clear();
        passwordcontroller.clear();
        conpasswordcontroller.clear();
        phonecontroller.clear();

        Get.to(()=>LoginPage());
      }

      catch (e) {
        Get.snackbar(
          "Firestore Error", "$e", snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,

        );
      }
    }
    else {
      Get.snackbar(
          backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          borderRadius: 10,
          "Auth Error", "SignUp Failed");
    }
  }
}