import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/controllers/googlesignin_controller.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/pages/appoinmentpage.dart';
import 'package:doctorapp/pages/particularcategory.dart';
import 'package:doctorapp/pages/payment.dart';
import 'package:doctorapp/pages/profilepage.dart';
import 'package:doctorapp/pages/searchdoctor.dart';
import 'package:doctorapp/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {

  const HomePage ({super.key});

  @override
  State<HomePage> createState() => _State();
}

class _State extends State<HomePage> {
  final TextEditingController doctorcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Welcome 👋"),
        actions: [
          IconButton(
            onPressed: () async{
              await Firestore().logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            tooltip: "Logout",
          ),
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
GestureDetector(
  onTap: (){
    Get.toNamed(("/searchdoctor"));
  },
  child: AbsorbPointer(

    child: TextInputField(

      onchanged: (value){

      },
      controller: doctorcontroller,
      hinttext: "Search Doctors",
    prefixicon: Icons.search,

    
    ),
  ),
),
        SizedBox(height: 30,),
        SizedBox(
          height: 50,
          child: StreamBuilder<List<Map<String,dynamic>>>(
            stream: Firestore().fetchdoctordetails(),
            builder: (context,snapshot){

              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(!snapshot.hasData || snapshot.data!.isEmpty){
                return Center(child: Text("No Categories Found"),);
              }
              var categorydata = snapshot.data!;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount:categorydata .length,
                itemBuilder: (context, index) {
                  var item = categorydata[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: (){
                        Get.to(Particularcategory(selectdoctor: item["category"].toString().toLowerCase()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            item['category'] ?? "",
                            style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },

          ),
        ),
            SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Popular Doctors",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: StreamBuilder<List<Map<String,dynamic>>>(
                  stream: Firestore().fetchDoctorNameAndCategory(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child:CircularProgressIndicator());
                    }
                    if(!snapshot.hasData || snapshot.data!.isEmpty){
                      return Center(child: Text("No Doctors Found",style: TextStyle(color: Colors.grey),),);
                    }
                    var data = snapshot.data!;
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context,index){
                          final doctor = data[index];
                          return GestureDetector(
                            onTap: (){
                              Get.to(Particularcategory(selectdoctor: doctor['category']));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.blue,
                                  width: 1,
                                ),
                              ),
                            color: Theme.of(context).cardColor,
                              child: Padding(padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                      AssetImage("assets/images/avatardoctorpreview.png"),
                                    ),
                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dr. ${doctor["name"] ?? "Unknown"}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          doctor["category"] ?? "Unknown",
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon( Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.grey,)
                                  ],
                                ),
                              ),
                            ),
                          );

                    });
                  }
                ),
              )
            ],
          ),
        ),

          ],
        ),
      ),
        bottomSheet: BottomNavigationBar(

          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          items: [

            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: (){
                    Get.to(()=>HomePage());
                  },
                  child: Icon(Icons.home_filled)),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: (){
                    Get.to(()=>SearchDoctor());
                  },
                  child: Icon(Icons.search)),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: (){
Get.to(()=>ProfilePage());
                  },
                  child: Icon(Icons.person)),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: (){
                    Get.to(()=>AppointmentPage());
                  },
                  child: Icon(Icons.book_online_rounded)),
              label: "Appointments",
            ),


            
          ],
        ),
      

    );
  }
}
