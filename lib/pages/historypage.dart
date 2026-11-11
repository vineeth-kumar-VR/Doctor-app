import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("Please Login"),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment History List",style: TextStyle(color: Colors.black),),
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("users").doc(user.uid).
          collection("successpayment").where("status", isEqualTo: "success").orderBy("createdat",descending: true).
          snapshots(),

          
          builder: (context, snapshot){
            print("HAS ERROR: ${snapshot.hasError}");
            print("ERROR: ${snapshot.error}");
            print("DOCUMENT COUNT: ${snapshot.data?.docs.length}");
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        };
            if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
              return Center(child: Text("No Successful Payment Found", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),);

            };

            final payment = snapshot.data!.docs;
            return ListView.builder(
                itemCount: payment.length,
                itemBuilder: (context, index){
                  final data = payment[index].data() as  Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.check_circle,color: Colors.green,),
                      title: Text(data["doctorname"] ?? "Doctor"),
                      subtitle: Text("PaymentId: ${data["paymentid"] ?? "N/A"}"),
                       trailing: Text('₹${data['amount'] ?? 0}'),

                    ),
                  );
                });
          })

    );
  }
}
