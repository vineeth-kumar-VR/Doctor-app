import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/pages/appoinmentpage.dart';
import 'package:doctorapp/pages/payment.dart';
import 'package:doctorapp/payment/payment_card_success.dart';
import 'package:doctorapp/payment/paymentcardpage.dart';
import 'package:doctorapp/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppoinmentDetails extends StatefulWidget {
  final Map<String,dynamic>appointmentlist;
  const AppoinmentDetails({super.key,required this.appointmentlist});

  @override
  State<AppoinmentDetails> createState() => _AppoinmentDetailsState();
}

class _AppoinmentDetailsState extends State<AppoinmentDetails> {


  Widget build(BuildContext context) {
    var data = widget.appointmentlist;
    print("APPOINTMENT DATA: $data");
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        leading: arrowback,
        backgroundColor: appbarcolor,
        title: Text("Back"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Map<String,dynamic>>>(
          stream: Firestore().fetchappointmentdetails(data["doctor"]),
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Appoinment Details:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
                  SizedBox(height: 10,),
                  appoinmentdetails(data,context,(){
                    Get.to( PaymentCardPage(
                      doctorname: data["doctor"],

                    ));
                  })
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

Widget appoinmentdetails(Map<String,dynamic>item, BuildContext context,VoidCallback onpay){

  return  Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
Text(" 👨‍⚕️ Doctor: ${item['doctor'] ?? "unkown"}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,)),
          SizedBox(height: 5,),

          Text(" 📍 Location: ${item['location']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
          SizedBox(height: 5,),
          Text(" 📅 Date & Time: ${item['date']},${item["time"]}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
          SizedBox(height: 5,),
          Text(" 👦 Name: ${item['name']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
          SizedBox(height: 5,),
          Text(" 🎂 Age: ${item['age']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
          SizedBox(height: 5,),
          Text(" ⚧️  Gender: ${item['gender']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
          SizedBox(height: 5,),
          SizedBox(height: 10,),
          Row(
            children: [
          //
          // Get.to(AppointmentPage());

  Expanded(
      child: Row(
        children: [
          ButtonsField(
            text: "Cancel Appointment",
            onpressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Cancel Appointment"),
                    content: Text("Are you sure you want to cancel this appointment?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Just close the dialog
                          Navigator.pop(context);
                        },
                        child: Text("No"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Firestore().deleteappointment(item["id"]);

                          Navigator.pop(context); // close dialog
                          Get.snackbar(
                            "Deleted",
                            "Appointment cancelled successfully",
                            snackPosition: SnackPosition.BOTTOM,
                          );

                          // Replace current page with AppointmentPage
                          Get.off(() => AppointmentPage());
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(width: 10,),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(

                onPressed: () {
                  print("Button Clicked");
onpay();
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
            ),
          )

        ],
      )
  ),

            ],
          )
        ],
      ),
      ),
    );

}
