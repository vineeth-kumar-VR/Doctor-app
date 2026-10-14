import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/controllers/payment_controller.dart';
import 'package:doctorapp/pages/credit_card_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentController controller = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Payment",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(padding: EdgeInsets.all(12),
      child: Column(
        children: [



          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(

              onPressed: () {
                Get.to(CreditCardPage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttoncolor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Pay Now",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )

        ],
      ),
      ),
    );
  }

}

