import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firebase_auth.dart';
import 'package:doctorapp/pages/doctordetail.dart';
import 'package:doctorapp/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController{
  final authentication = Authentication();

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  Future<void>logincheck()async{
    if(emailcontroller.text.trim().isEmpty || passwordcontroller.text.trim().isEmpty){
      Get.snackbar(
          borderRadius: 10,
          backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          "Error", "Please Enter All The Fields");
      return;
    }

      try{
        User? user = await authentication.login(emailcontroller.text.trim(), passwordcontroller.text.trim());

        if(user!=null){
          Get.snackbar(
            "Success", "Login Successful",
            snackPosition: SnackPosition.BOTTOM,
            borderRadius: 10,
            backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          );
          emailcontroller.clear();
          passwordcontroller.clear();
          Get.to(()=>HomePage());
       }
        else{
          Get.snackbar(
            "Auth Error", "Login Failed",
            snackPosition: SnackPosition.BOTTOM,
            borderRadius: 10,
            backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
          );
        }
      }
    catch(e){
      Get.snackbar(
        "Error", "$e",
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      );
    }

  }
}