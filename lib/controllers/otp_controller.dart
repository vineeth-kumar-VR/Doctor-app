import 'package:doctorapp/pages/otppage.dart';
import 'package:doctorapp/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final phonecontroller = TextEditingController();
  final otpcontroller = TextEditingController();

  String verifyid = "";

  // SEND OTP
  Future<void> sendotp() async {
    String phone = phonecontroller.text.trim();

    print("PHONE NUMBER: $phone");

    if (phone.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter mobile number",
      );
      return;
    }

    if (phone.length != 10) {
      Get.snackbar(
        "Error",
        "Enter a valid 10 digit mobile number",
      );
      return;
    }

    try {
      print("Sending OTP...");

      await auth.verifyPhoneNumber(
        phoneNumber: '+91$phone',

        verificationCompleted:
            (PhoneAuthCredential credential) async {
          print("Verification completed");

          await auth.signInWithCredential(credential);

          Get.offAll(() => HomePage());
        },

        verificationFailed:
            (FirebaseAuthException error) {
          print("OTP ERROR: ${error.code}");
          print("MESSAGE: ${error.message}");

          Get.snackbar(
            "OTP Error",
            error.message ?? "OTP Verification Failed",
          );
        },

        codeSent: (String verificationId, int? resendToken) {
          print("OTP SENT");

          verifyid = verificationId;

          Get.dialog(
            AlertDialog(
              title: const Text("OTP Sent"),
              content: const Text(
                "Your test OTP is: 123456",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back(); // close popup
                    Get.to(() => OtpPage()); // open OTP page
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
            barrierDismissible: false,
          );
        },

        codeAutoRetrievalTimeout:
            (String verificationId) {
          print("Auto retrieval timeout");

          verifyid = verificationId;
        },
      );
    } catch (e) {
      print("ERROR: $e");

      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  // VERIFY OTP
  Future<void> verifyotp() async {
    String otp = otpcontroller.text.trim();

    print("OTP ENTERED: $otp");

    if (otp.length != 6) {
      Get.snackbar(
        "Error",
        "Please enter 6 digit OTP",
      );
      return;
    }

    if (verifyid.isEmpty) {
      Get.snackbar(
        "Error",
        "Verification ID is missing",
      );
      return;
    }

    try {
      print("Verifying OTP...");

      PhoneAuthCredential credential =
      PhoneAuthProvider.credential(
        verificationId: verifyid,
        smsCode: otp,
      );

      await auth.signInWithCredential(credential);

      print("OTP VERIFIED");

      Get.snackbar(
        "Success",
        "OTP Verified Successfully",
      );

      Get.offAll(() => HomePage());
    } catch (e) {
      print("OTP VERIFY ERROR: $e");

      Get.snackbar(
        "Error",
        "Invalid OTP",
      );
    }
  }

  @override
  void onClose() {
    phonecontroller.dispose();
    otpcontroller.dispose();

    super.onClose();
  }
}