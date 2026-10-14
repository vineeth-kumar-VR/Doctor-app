import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Appointment_Controller extends GetxController{
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();
  var selectindex = 0.obs;
  var selectindex1 = 0.obs;
  var selectgender = "".obs;
}