import 'package:doctorapp/controllers/otp_controller.dart';
import 'package:doctorapp/widgets/buttons.dart';
import 'package:doctorapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final OtpController otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("OTP Verification"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 40),

              const Icon(
                Icons.phone_android,
                size: 80,
              ),

              const SizedBox(height: 20),

              const Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Enter the 6 digit OTP sent to your mobile number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 40),

              TextInputField(
                controller: otpController.otpcontroller,
                hinttext: "Enter 6 digit OTP",
                prefixicon: Icons.lock_outline,
                onchanged: (value) {},
              ),

              const SizedBox(height: 20),

              ButtonsField(
                text: "Verify OTP",
                onpressed: () {
                  otpController.verifyotp();
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}