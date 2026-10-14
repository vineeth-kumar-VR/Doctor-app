import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';
class PaymentCardPage extends StatefulWidget {
  final String doctorname;
  const PaymentCardPage({super.key, required this.doctorname,});

  @override
  State<PaymentCardPage> createState() => _PaymentCardPage();
}

class _PaymentCardPage extends State<PaymentCardPage> {

  late Razorpay razorpay;
  @override
  void initState(){
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,_handlepaymentsuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlepaymentfailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleexternalwallet);
  }
 void openCheckout(){
    var options = {
      'key': 'rzp_test_Swo5l9oGcihQu1',
      'amount': 50000,
      'name': 'Doctor App',
      'description': 'Appointment Payment',
      'prefill': {
        'contact': '9999999999',
        'email': 'test@example.com'
      }
    };
    razorpay.open(options);
  }
  void _handlepaymentsuccess(PaymentSuccessResponse response){
    print("Success${response.paymentId}");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment Success")));
  }
  void _handlepaymentfailure(PaymentFailureResponse response){
    print("Error${response.error}");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payment Failed")));
  }
  void _handleexternalwallet(ExternalWalletResponse response){
    print("Error${response.walletName}");
  }
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currdate = DateFormat("dd-MM-yy").format(now);
    final currtime = DateFormat("hh:mm a").format(now);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 10),

                     Text(
                      widget.doctorname,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),




                    const Divider(height: 30),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Appointment Fee"),
                        Text(
                          "₹500",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children:  [
                        Text("Date"),
                        Text(currdate),
                      ],
                    ),

                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children:  [
                        Text("Time"),
                        Text(currtime),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Your payment is secured by Razorpay",
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: openCheckout,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Pay ₹500",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
