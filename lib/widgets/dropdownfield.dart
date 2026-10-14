import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/controllers/appointment_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({super.key});

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  final List<String> genderOptions = ["Male", "Female", "Other"];
  final Appointment_Controller controller = Get.put(Appointment_Controller());
String? isselectgender;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(

        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue),
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(

              value: isselectgender,
              hint: Text("Gender", style: TextStyle(color: Colors.grey[700])),
isExpanded: true,
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              icon: Icon(Icons.arrow_drop_down),
              items: genderOptions.map((String value){
                return DropdownMenuItem<String>(

                    value: value,
                    child: Text(value,style: TextStyle(fontSize: 16),));
              }).toList(),
              
              onChanged: (newvalue){
                setState(() {
                  isselectgender = newvalue;
                });
                controller.selectgender.value = newvalue ?? "";
              })),
    );
  }
}
