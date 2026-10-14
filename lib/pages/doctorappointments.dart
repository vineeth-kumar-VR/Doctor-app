import 'package:doctorapp/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/database/firestore.dart';

class DoctorAppointmentPage extends StatefulWidget {
  const DoctorAppointmentPage({super.key});

  @override
  State<DoctorAppointmentPage> createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appbarcolor,
        title: Text("Appointments",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
      ),
      body:
    StreamBuilder(stream: Firestore().fetchappointments(), builder: (context,snapshot){
      if (snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      if (!snapshot.hasData || snapshot.data!.isEmpty){
        return Center(child: Text("No Data Found",style: TextStyle(color: Colors.black),),);
      }
      var data = snapshot.data!;
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,index){
var appointment = data[index];
        return Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListTile(
            leading: Icon(Icons.local_hospital_outlined,size: 20,color: Colors.blue,),
            title: Text(
              appointment["doctor"] ?? "No Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date: ${appointment['date'] ?? ''}",style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Time: ${appointment['time'] ?? ''}",style: TextStyle(fontWeight: FontWeight.bold),),
                Text("Gender: ${appointment['gender'] ?? ''}",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        );
      });
    })

    );
  }
}
