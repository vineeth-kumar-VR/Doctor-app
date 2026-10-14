import 'package:get/get.dart';

class PaymentController extends GetxController{
  var selectmethod = "card".obs;
  void selectmenthod(String value){
    selectmethod.value = value;
  }
}