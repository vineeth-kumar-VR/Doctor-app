import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentCardSuccess extends StatefulWidget {
  const PaymentCardSuccess({super.key});

  @override
  State<PaymentCardSuccess> createState() => _PaymentCardSuccessState();
}

class _PaymentCardSuccessState extends State<PaymentCardSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Payment Success",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(padding: EdgeInsets.all(10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
            "assets/animation/Card Payment Successful.json",
              height: 500,
              width: 500,
              repeat: false
        ),
            Text(
              "Payment Done!",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],

      ),
        ),
    );
  }
}
