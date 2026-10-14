import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/controllers/appointment_booking_controller.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/pages/appoinmentpage.dart';
import 'package:doctorapp/widgets/buttons.dart';
import 'package:doctorapp/widgets/dropdownfield.dart';
import 'package:doctorapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookAppinmentPage extends StatefulWidget {
  final Map<String,dynamic>doctordata;
  const BookAppinmentPage({super.key, required this.doctordata});

  @override
  State<BookAppinmentPage> createState() => _BookAppinmentPageState();
}

class _BookAppinmentPageState extends State<BookAppinmentPage> {

final Appointment_Controller controller = Get.put(Appointment_Controller());

  @override
  Widget build(BuildContext context) {
  final Map<String,dynamic> doctor = widget.doctordata ;
  final slotskey = doctor["timeslots"].keys.toList();

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Text("Book Appoinment", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18),),
    ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          personandlocation(Icon(Icons.person), "Doctor:", doctor["about"] ?? ""),
SizedBox(height: 5,),
              personandlocation(Icon(Icons.business), "Hospital:", doctor["location"] ?? ""),
              Divider(thickness: 1,),
              SizedBox(height: 30,),
              Text("Choose Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
          SizedBox(height: 5,),
              SingleChildScrollView(
    scrollDirection: Axis.horizontal,
                child: Obx(()=> Row(
                  children: List.generate(7, (index){
                    final DateTime date = DateTime.now().add(
                        Duration(days: (index))
                    );
                    final String dateText = DateFormat("EEE MMM d").format(date);
                        return chosedate(dateText,controller.selectindex.value == index,
                            (){
                          controller.selectindex.value = index;

                            },
                        );
                  }),
                )
                ),
              ),
              SizedBox(height: 30,),
              Text("Choose Time Slot",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
              SizedBox(height: 5,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:Obx(()=>
                    Row(
                      children: List.generate(doctor["timeslots"].length, (index){
                        final key = slotskey[index];
                        final start = doctor["timeslots"][key]?["start"] ?? "";
                        final end = doctor["timeslots"][key]?["end"] ?? "";
                        final time = "$start - $end";

                        return timeslots(time, controller.selectindex1 == index, (){
                          controller. selectindex1.value = index;
                        });
                      }),
                    ),),
              ),
              SizedBox(height: 20,),
              Text("Patient Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
              SizedBox(height: 5,),
              TextInputField(
                onchanged: (value){

                },
                controller:controller.namecontroller,
                hinttext: "Name",
              prefixicon: null,
              ),
              TextInputField(
                onchanged: (value){

                },
                controller:controller.agecontroller,
                hinttext: "Age",
              prefixicon: null,
              ),
              SizedBox(height: 4,),
              DropDownField(),
              SizedBox(height: 30,),
              ButtonsField(text: "Book Appoinment",
                  onpressed: () async {
                    if (controller.namecontroller.text.trim().isEmpty ||
                        controller.agecontroller.text.trim().isEmpty ||
                        controller.selectgender.value.isEmpty) {
                      Get.snackbar(
                        borderRadius: 10,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        "Error",
                        "Please fill all patient details",
                      );
                      return;
                    }

                    // validate index
                    if (controller.selectindex.value < 0 ||
                        controller.selectindex.value >= doctor["weekdays"].length ||
                        controller.selectindex1.value < 0 ||
                        controller.selectindex1.value >= doctor["timeslots"].length) {
                      Get.snackbar(
                        borderRadius: 10,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        "Error",
                        "Please select a valid date and time slot",
                      );
                      return;
                    }

                    try {
                      final date =
                          "${doctor["weekdays"][controller.selectindex.value]} ${doctor["weekcount"][controller.selectindex.value]}";

                      final slotskey = doctor["timeslots"].keys.toList();
                      final time =
                          "${doctor["timeslots"][slotskey[controller.selectindex1.value]]?["start"]} - ${doctor["timeslots"][slotskey[controller.selectindex1.value]]?["end"]}";

                      await Firestore().bookappointment(
                        doctorname: doctor["about"] ?? "",
                        location: doctor["location"] ?? "",
                        date: date,
                        time: time,
                        name: controller.namecontroller.text,
                        age: controller.agecontroller.text,
                        gender: controller.selectgender.value,
                      );

                      // reset after saving
                      controller.namecontroller.clear();
                      controller.agecontroller.clear();
                      controller.selectgender.value = "";
                      controller.selectindex.value = -1;
                      controller.selectindex1.value = -1;

                      Get.to(AppointmentPage());
                    } catch (e) {
                      print("Error save appoinment $e");
                    }
                  }

              )


            ],
          ),
        ),
      )),
    );
  }
}

Widget personandlocation(Icon icon, String label, String value){
  return  Row(
      children: [
        icon,
        SizedBox(width: 5,),
        Text(label,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        SizedBox(width: 5,),
        Text(value,style: TextStyle(fontSize: 15),)
      ],
    );

}

Widget chosedate(String label, bool isselect, VoidCallback ontap){
  return  GestureDetector(
  onTap: ontap,
  child: Container(
margin: EdgeInsets.only(right: 10),
height: 40,
padding: EdgeInsets.symmetric(horizontal: 16),
decoration: BoxDecoration(
color: isselect ? appbarcolor : buttoncolor,
borderRadius: BorderRadius.circular(10),
border: Border.all(color: Colors.grey.shade400),
),
child: Center(
child: Text(
label,
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
color: isselect ? Colors.white : Colors.black,
),
),
),
),
  );

}

Widget timeslots(String label, bool selectedindex, VoidCallback ontap){
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: selectedindex ? appbarcolor : buttoncolor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: selectedindex ? Colors.white : Colors.black,
          ),
        ),
      ),
    ),
  );
}
