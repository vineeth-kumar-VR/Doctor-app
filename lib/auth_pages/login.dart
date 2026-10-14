import 'package:doctorapp/auth_pages/forgetpassword.dart';
import 'package:doctorapp/auth_pages/signup.dart';
import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/controllers/login_controller.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/widgets/buttons.dart';
import 'package:doctorapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorapp/controllers/otp_controller.dart';
import 'package:doctorapp/controllers/googlesignin_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SignInController signInController = Get.put(SignInController());
  final LoginController loginController = Get.put(LoginController());
  final OtpController otpController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                        height: 100,
                        width: 100,
                        "assets/images/stescope-removebg-preview.png"),
                    Text("WelCome Back!",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                    Text("Please SignIn To Continue",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey.shade500),),
                  ],
                ),
              ),
        
        SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Email",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
              TextInputField(
                  onchanged: (value){

                  },
                  controller: loginController.emailcontroller,
                  hinttext: "Email", prefixicon: Icons.email_outlined),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Password",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
              TextInputField(
                  onchanged: (value){

                  },
                  controller: loginController.passwordcontroller,
                  hinttext: "Password", prefixicon: Icons.privacy_tip_outlined,
                obsecure: true,

              ),
        

              SizedBox(height: 20,),
              ButtonsField(text: "Login",
              onpressed: (){
        loginController.logincheck();
              },
              ),
              SizedBox(height: 5),

              const Center(
                child: Text(
                  "OR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.offAll(() => SignUP());
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),


                  OutlinedButton.icon(
                    onPressed: () {
                      signInController.signinwithgoogle();
                    },
                    icon: Image.asset(
                      'assets/images/google.jpg',
                      height: 22,
                      width: 22,
                    ),
                    label: const Text("Google"),
                  ),
                ],
              ),


              const SizedBox(height: 10),


              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Mobile Number",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              TextInputField(
                onchanged: (value) {},
                controller: otpController.phonecontroller,
                hinttext: "Enter mobile number",
                prefixicon: Icons.phone,
              ),

              const SizedBox(height: 10),

              ButtonsField(
                text: "Send OTP",
                onpressed: () {
                  print("SEND OTP BUTTON CLICKED");
                  otpController.sendotp();
                },
              ),
        
        
            ],
          ),
        ),
      ),
    );
  }
}
