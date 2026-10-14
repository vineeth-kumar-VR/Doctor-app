import 'package:doctorapp/auth_pages/login.dart';
import 'package:doctorapp/auth_pages/signup.dart';
import 'package:doctorapp/controllers/theme_controller.dart';
import 'package:doctorapp/firebase_options.dart';
import 'package:doctorapp/pages/editpage.dart';
import 'package:doctorapp/pages/homepage.dart';
import 'package:doctorapp/pages/particularcategory.dart';
import 'package:doctorapp/pages/profilepage.dart';
import 'package:doctorapp/pages/searchdoctor.dart';
import 'package:doctorapp/pages/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController controller = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return  Obx(() {
     return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: controller.isdark.value ? ThemeData.dark():ThemeData.light(),

        initialRoute: "/",

        getPages: [
          GetPage(name: "/", page: () => Splashscreen()),
          GetPage(name: "/signup", page: () => SignUP()),
          GetPage(name: "/home", page: () => HomePage()),
          GetPage(
            name: "/Particularcategory",
            page: () => Particularcategory(selectdoctor: ""),
          ),
          GetPage(name: "/searchdoctor", page: () => SearchDoctor()),
        ],
      );

    } );

  }
}
//Splash → Login/Signup → Home Page → Doctor List → Doctor Detail → Appointment Booking → Confirmation