import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/pages/appoinmentdetails.dart';
import 'package:doctorapp/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("My Appoinments"),
        leading: arrowback,
        centerTitle: true,
        backgroundColor: appbarcolor,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Map<String,dynamic>>>(
          stream: Firestore().fetchappointment(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: Theme.of(context).scaffoldBackgroundColor,),);
            }
            if(!snapshot.hasData || snapshot.data!.isEmpty){
              return Center(child: Text("No Appointments Found"),);
            }
            var appointmentlist = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      calender,
                      Text("Upcoming Appoinments",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                      SizedBox(height: 5,),

                    ],
                  ),
                  appoinments(appointmentlist),
                  SizedBox(height: 10,),

                  Text("Past Appoinments",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
                  pastappoinment()


                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

Widget appoinments(List<Map<String,dynamic>>appointmentlist){

  return ListView.builder(
    shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: appointmentlist.length,
      itemBuilder: (context,index){
        var item  = appointmentlist[index];
return Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    side: BorderSide(width: 1,color: Colors.blue)
  ),
  color: Theme.of(context).scaffoldBackgroundColor,
  child: Padding(padding: EdgeInsets.all(8),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("👨‍⚕️ ${item["doctor"]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
      SizedBox(height: 5,),
      Text(" 🏥 ${item["location"]}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
      SizedBox(height: 10,),
      Text("🕒 ${item["date"]},${item["time"]}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),
      SizedBox(height: 5,),
      Row(mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonsField(text: "View Details",
          onpressed: (){
Get.to(()=> AppoinmentDetails(appointmentlist: item,));
          },
          ),


        ],
      )




    ],
  ),
  ),

);
  });
}

Widget pastappoinment(){

  return StreamBuilder<List<Map<String,dynamic>>>(
    stream: Firestore().fetchdeleteappointments(),
    builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      if(!snapshot.hasData || snapshot.data!.isEmpty){
        return Center(child: Text("No Past Appointments Found"),);

      }
     var data = snapshot.data!;
      return ListView.builder(
        shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (contex,index){
            var item = data[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  width: 1,color: Colors.blue
                )
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("👨‍⚕️ ${item["doctor"]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 5,),
                  Text(" 📅 ${item["date"]}" ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
                  SizedBox(height: 5,),
                  Text(" ⏰ ${item["time"]}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
                  SizedBox(height: 5,),

                  Text(" 👦 ${item["name"]}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),
                  SizedBox(height: 5,),
                  Text(" 🎂 ${item["age"]}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),                  SizedBox(height: 5,),
                  SizedBox(height: 5,),
                  Text(" ⚧️ ${item["gender"]}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,)),                  SizedBox(height: 5,),



                ],
              ),
              ),
            );
          });
    }
  );
}