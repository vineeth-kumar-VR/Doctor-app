import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/controllers/theme_controller.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/pages/doctorappointments.dart';
import 'package:doctorapp/pages/editpage.dart';
import 'package:doctorapp/pages/favouritedoctorpage.dart';
import 'package:doctorapp/pages/helppage.dart';
import 'package:doctorapp/pages/privacypage.dart';
import 'package:doctorapp/pages/termspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ThemeController controller = Get.find();

bool isbool = false;
  List<Map<String,dynamic>>dataitem = [
    {
      'title':'My Appointments',
      'icon':Icons.arrow_forward,
      'page':DoctorAppointmentPage()
    },
    {
      'title':'My Favourite Doctors',
      'icon':Icons.arrow_forward,
      'page': FavouriteDoctorPage()
    },
    {
      'title':'Dark Mode',
      'type':'switch'
    },
    {
      'title':'Help & Support',
      'icon':Icons.arrow_forward,
      'page': HelpPage()
    },
    {
      'title':'Privacy Policy',
      'icon':Icons.arrow_forward,
      'page': PrivacyPage()
    },
    {
      'title':'Terms & Conditions',
      'icon':Icons.arrow_forward,
      'page':TermsPage()
    }
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,

        title: Text("Profile Page", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: CircleAvatar(
                radius: 50,
                child: Image.asset("assets/images/avatardoctorpreview.png"),
              ),
            ),
            SizedBox(height: 30,),
        StreamBuilder<Map<String, dynamic>?>(
          stream: Firestore().fetchnamemail(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const Text(
                "No Name and Email Found",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              );
            }

            final user = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Name: ${user['name'] ?? ''}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),

                const SizedBox(height: 10),

                Text(
                  "Email: ${user['email'] ?? ''}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        
                        backgroundColor: buttoncolor,
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      onPressed: () {
                        Get.to(EditPage(
                          name: user['name'] ?? "",
                          email: user['email'] ?? "",
                        ));
                      },

                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),



        SizedBox(height: 20,),
          
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ListView.builder(
                   shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dataitem.length,
                    itemBuilder: (context,index){
                      var item = dataitem[index];
                      return Column(
                        children: [
                        Card(
                          color: Theme.of(context).cardColor,
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: item['type'] == 'switch' ? null:(){
                            if(item['page'] != null){
                              Get.to(item['page']);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Title
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                // Trailing widget
                                item["type"] == 'switch'
                                    ?  Obx(() => Switch(
                                  value: controller.isdark.value,
                                  onChanged: (value) {
                                    controller.toggletheme(value);
                                  },
                                ))
                                    : const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )


                        ],
                      );
                    }),
               ),
           
          ],
        ),
      ),
    );
  }
}
