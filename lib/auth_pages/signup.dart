import 'package:doctorapp/auth_pages/login.dart';
import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/controllers/signup_controller.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/widgets/buttons.dart';
import 'package:doctorapp/widgets/textbuttons.dart';
import 'package:doctorapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  bool obsecurepassword = true;
  bool obsecureconpassword = true;
  final SignupController signupController = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appbarcolor,
        title: Text("Create Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 40,),
              TextInputField(
                  onchanged: (value){

                  },
                  controller: signupController.namecontroller,
                  hinttext: "FullName", prefixicon: Icons.person),
              SizedBox(height: 10,),
              TextInputField(
                  onchanged: (value){

                  },
                  controller: signupController.emailcontroller,
                  hinttext: "Email", prefixicon: Icons.email_outlined),
              SizedBox(height: 10,),
              TextInputField(
                obsecure: true,
                  onchanged: (value){

                  },
                  controller: signupController.passwordcontroller,
                  hinttext: "Password", prefixicon: Icons.privacy_tip_outlined),
              SizedBox(height: 10,),
              TextInputField(
                  obsecure: true,
                  onchanged: (value){

                  },
                  controller: signupController.conpasswordcontroller,
                  hinttext: "Confirm Password", prefixicon: Icons.privacy_tip_outlined),
              SizedBox(height: 10,),
              TextInputField(

                  onchanged: (value){

                  },
                  controller: signupController.phonecontroller,
                  hinttext: "Phone", prefixicon: Icons.phone_android),
              SizedBox(height: 30,),
              
              ButtonsField(text: "SignUp",
              onpressed: (){
                signupController.signup();
              },
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Already Have An Account?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
Textbuttons(text: "Login",
   onpressed: (){
  Get.to(LoginPage());
   },
)
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
