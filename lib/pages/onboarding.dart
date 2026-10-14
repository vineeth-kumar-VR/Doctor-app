import 'package:doctorapp/auth_pages/login.dart';
import 'package:doctorapp/auth_pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pagecontroller = PageController();
  int current_index = 0;
  Future<void>finishonboard()async{
    final pref = await SharedPreferences.getInstance();
    await pref.setBool("onboardcomplete", true);

    Get.offAll(() => LoginPage());
  }
  final List<Map<String,dynamic>> onboarding = [
    {
      "image": "assets/images/girl1-removebg-preview.png",
      "title": "Find Your Doctor",
      "description":
      "Find the right doctor based on your health needs.",
    },

    {
      "image": "assets/images/boy1-removebg-preview.png",
      "title": "Book Appointment",
      "description":
      "Choose your preferred doctor, date and time easily.",
    },

    {
      "image": "assets/images/boy-removebg-preview.png",
      "title": "Take Care of Your Health",
      "description":
      "Manage your appointments and stay connected with healthcare.",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton(onPressed: (){
              finishonboard();

            }, child:Text("Skip",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.white),)),
          ),
          Expanded(child: PageView.builder(
              controller: pagecontroller,
              itemCount: onboarding.length,
              onPageChanged: (index){
                setState(() {
                  current_index = index;
                });
              },
              itemBuilder: (context,index){
                return Padding(padding: EdgeInsets.symmetric(
                  horizontal: 25
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                      onboarding[index]["image"]
                  ),
                      SizedBox(height: 40,),
                      Text(onboarding[index]["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(height: 40,),
                      Text(onboarding[index]["description"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.white
                        ),
                      )


                    ],
                  ),

                );
              })),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(onboarding.length,
      (index){
    return AnimatedContainer(duration: Duration(milliseconds: 2),
    margin: EdgeInsets.symmetric(
      horizontal: 4,
    ),
      height: 8,
      width: current_index == index ? 25 : 8,
      decoration: BoxDecoration(
        color: current_index == index? Theme.of(context).primaryColor:Colors.grey,
        borderRadius: BorderRadius.circular(10)
      ),
    );
      }
      ),
),
          SizedBox(height: 30,),
          Padding(padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: SizedBox(height: 55,
width: double.infinity,
child: ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
    onPressed: (){
  if(current_index == onboarding.length-1){
    finishonboard();
  }
  else{
    pagecontroller.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}, child: Text(
 current_index == onboarding.length-1? "Get Started":"Next",
  style: TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: Colors.white
  ),
)),
          ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),


      ),
    );
  }
}
