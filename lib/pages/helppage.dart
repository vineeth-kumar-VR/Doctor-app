import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: Text("Help & Support", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Icon(Icons.help_outline,size: 70,),
          SizedBox(height: 10,),
          Center(
            child: Text("How Can We Help You", style: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 10,),
          Card(
            child: ExpansionTile( leading: const Icon(Icons.calendar_month),
              title: const Text("How to book an appointment?",style: TextStyle(fontWeight: FontWeight.bold),),
            children: [
              Padding(padding: EdgeInsets.all(10),
              child: Text( "Select a doctor, choose an available date "
                  "and time, then confirm your appointment.",style: TextStyle(fontWeight: FontWeight.bold),),
              )
            ],
            ),
          ),
          Card(
            child: ExpansionTile( leading: const Icon(Icons.event),
              title: const Text("Where I can see the Appointments?",style: TextStyle(fontWeight: FontWeight.bold),),
              children: [
                Padding(padding: EdgeInsets.all(10),
                  child: Text(  "Go to Profile and select My Appointments "
                      "to view your appointments.",style: TextStyle(fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile( leading: const Icon(Icons.phone_android),
              title: const Text("What if I don't receive OTP?",style: TextStyle(fontWeight: FontWeight.bold),),
              children: [
                Padding(padding: EdgeInsets.all(10),
                  child: Text("Check your mobile number and internet connection "
                      "and try sending the OTP again.",style: TextStyle(fontWeight: FontWeight.bold),),
                )
              ],
            ),

          ),
          Card(
            child: ExpansionTile( leading: const Icon(Icons.payment),
              title: const Text("What if payment fails?",style: TextStyle(fontWeight: FontWeight.bold),),
              children: [
                Padding(padding: EdgeInsets.all(10),
                  child: Text(  "Please check your internet connection and "
                      "try the payment again.",style: TextStyle(fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),
          Card(
            child: ExpansionTile( leading: const Icon(Icons.person),
              title: const Text("How can I find a doctor?",style: TextStyle(fontWeight: FontWeight.bold),),
              children: [
                Padding(padding: EdgeInsets.all(10),
                  child: Text( "You can search for a doctor or select a "
                      "doctor category from the home page.",style: TextStyle(fontWeight: FontWeight.bold),),
                )
              ],
            ),
          ),
           SizedBox(height: 25),

          const Center(
            child: Text(
              "Need more help?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Center(
            child: Text(
              "Contact us at support@doctorapp.com",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      )
    );
  }
}
