import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ThemeController extends GetxController{
  var isdark = false.obs;
  void toggletheme(bool value){
    isdark.value = value;
    if(value){
      return Get.changeTheme(ThemeData.dark());
    }
    else{
      return Get.changeTheme(ThemeData.light());
    }
  }

}