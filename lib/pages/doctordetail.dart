import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/pages/bookappoinment.dart';
import 'package:doctorapp/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoctorDetail extends StatefulWidget {
final Map<String,dynamic> doctordata;
  const DoctorDetail({super.key,required this.doctordata});

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  @override
  Widget build(BuildContext context) {

    var doctordata = widget.doctordata;
    print("Doctor data passed in: $doctordata");

    var doctor = doctordata;
    Map<String,dynamic> timeslot = doctor["timeslots"] ?? {};
    String morningtime = "${timeslot["morning"]["start"]} - ${timeslot["morning"]["end"]}";
    String afternoontime = "${timeslot["afternoon"]["start"]} - ${timeslot["afternoon"]["end"]}";
    String eveningtime = "${timeslot["evening"]["start"]} - ${timeslot["evening"]["end"]}";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Doctor Detail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(

          child:  Padding(padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Center(
                    child:  CircleAvatar(

                        radius: 40,
                        child: Image.asset(
                          height: 100,
                          width: 150,
                          "assets/images/avatardoctorpreview.png",
                        fit: BoxFit.cover,
                        ),
                      ),

                  ),
                  SizedBox(height: 20,),
              InfoRow(Icon(Icons.location_on,color: textcolor,), "Location:", doctordata["location"] ?? ""),
                  SizedBox(height: 5,),
                  InfoRow(Icon(Icons.work,color: textcolor,), "Experience:", doctordata["experience"] ?? ""),
                  SizedBox(height: 5,),

                  InfoRow(Icon(Icons.star,color: Colors.yellow,), "Ratings:", doctordata["rating"] ?? ""),
                  SizedBox(height: 5,),

                  InfoRow(Icon(Icons.language,color: textcolor,), "Languages:", (doctordata["language"] as List<dynamic>?)?.join("") ?? ""),
                  SizedBox(height: 20,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                          children: [
                            Icon(Icons.description),
                            SizedBox(width: 5,),
                            Text("About",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                          ],
                        ),
                      SizedBox(height: 5,),
                      Text(doctordata["about"],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

                    ],
                  ),
                  Divider(thickness: 1,),
                  SizedBox(height: 10,),
                  Text("Available Dates", style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                       Row(
                        children: List.generate(7, (index){
                          DateTime date = DateTime.now().add(
                            Duration(days: index),
                          );
                          String weekday = DateFormat("EEE").format(date);
                          String dateText = DateFormat("MMM d").format(date);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Container(

                              padding: const EdgeInsets.symmetric(

                                horizontal: 8,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DateRow(weekday, dateText),
                            ),
                          );

                        }

                        ),
                      ),

                  ),
                  SizedBox(height: 20,),
                  Text("Available Time Slots",style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TimeSlots("Morning", morningtime),
                        TimeSlots("Afternoon", afternoontime),
                        TimeSlots("Evening", eveningtime),

                      ],
                    ),

                  ),
                  SizedBox(height: 40,),
                  ButtonsField(text: "Appoinment", onpressed: (){
                    Get.to(BookAppinmentPage(doctordata: doctor,));
                  })


                ],
              ),
              ),

        ),
      ),
    );
  }
}


Widget InfoRow(Icon icon, String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      icon,
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),
          softWrap: true,
        ),
      ),
    ],
  );
}


Widget DateRow(String label, String value) {
  return Container(
    width: 65,
    padding: const EdgeInsets.symmetric(
      horizontal: 4,
      vertical: 8,
    ),
    decoration: BoxDecoration(
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    ),
  );
}


Widget TimeSlots(String label, String value) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        color: Theme.of(Get.context!).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 13),
            softWrap: true,
          ),
        ],
      ),
    ),
  );
}
