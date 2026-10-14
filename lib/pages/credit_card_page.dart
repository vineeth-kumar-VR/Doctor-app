import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/payment/payment_card_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Card Details",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(padding: EdgeInsets.all(10),
      child: Column(
        children: [

          TextField(
            decoration: InputDecoration(
              labelText: "Card Number",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),

          SizedBox(height: 10),

          TextField(
            decoration: InputDecoration(
              labelText: "Card Holder",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Expiry",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "CVV",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),

          Spacer(),

          SizedBox(

            height: 50,
            width: double.infinity,
            child: ElevatedButton(

              onPressed: () {
               Get.to(PaymentCardSuccess());
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
      )
      ),
    );
  }
}
