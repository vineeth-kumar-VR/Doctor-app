
import 'package:doctorapp/auth_pages/login.dart';
import 'package:doctorapp/pages/homepage.dart';
import 'package:doctorapp/pages/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  double opacity = 0.0;
  double scale = 0.8;
  Future<void>checkuser()async{
    await Future.delayed(Duration(seconds: 3));
  final pref = await SharedPreferences.getInstance();
  bool onboardcomplete = pref.getBool("onboardcomplete") ?? false;
  User? user = FirebaseAuth.instance.currentUser;
  if(!onboardcomplete){
    Get.offAll(()=>OnboardingScreen());
  }
  else if(user!=null){
    Get.offAll(()=>HomePage());
  }
  else{
    Get.offAll(()=>LoginPage());
  }
  }
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1.0;
        scale = 1.0;
      });
    });

    checkuser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(microseconds: 1000),
              curve: Curves.easeInOut,
              child: AnimatedScale(scale: scale, duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
                child: Image.asset(
                    height: 200,
                    width: 200,
                    "assets/images/OIP-removebg-preview.png"),
              ),

            ),

            const Text(
              "Doctor App",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Your Health, Our Priority",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
