import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/pages/profilepage.dart';
import 'package:doctorapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPage extends StatefulWidget {
final String name;
final String email;
  const EditPage({super.key,required this.name,required this.email});

  @override

  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
late TextEditingController namecontroller;
late TextEditingController emailcontroller;
void initState(){
  super.initState();
  namecontroller = TextEditingController(text:  widget.name);
  emailcontroller = TextEditingController(text: widget.email);
}
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appbarcolor,
        title: Text("Edit User Page",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),),

      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextInputField(hinttext: "Email", prefixicon: Icons.person, controller: namecontroller, onchanged: (value){
        
            }),
            SizedBox(height: 10,),
            TextInputField(hinttext: "Username", prefixicon: Icons.email_outlined, controller: emailcontroller, onchanged: (value){
        
            }),
            SizedBox(height: 10,),
            Container(
              height: 40,
              child:ElevatedButton(
                onPressed: () async {

                  String updatedName = namecontroller.text.trim();
                  String updatedEmail = emailcontroller.text.trim();

                  if (updatedName.isEmpty || updatedEmail.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fields cannot be empty")),
                    );
                    return;
                  }

                  bool success = await Firestore().updatenameemail(
                    name: updatedName,
                    email: updatedEmail,
                  );

                  if (success) {
                    Get.back(); // go back to ProfilePage
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Update Failed")),
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: buttoncolor,
                ),

                child: const Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )

            ),
          ],
        ),
        ),
      ),
    );
  }
}
