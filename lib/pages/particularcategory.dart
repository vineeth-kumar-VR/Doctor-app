import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/pages/doctordetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Particularcategory extends StatefulWidget {
 final String selectdoctor;
  const Particularcategory({super.key,required this.selectdoctor});

  @override
  State<Particularcategory> createState() => _ParticularcategoryState();
}

class _ParticularcategoryState extends State<Particularcategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: arrowback,
        backgroundColor: appbarcolor,
        title: Text("Specialist Doctors"),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: StreamBuilder<List<Map<String,dynamic>>>(
          stream: Firestore().fetchdoctorcategory(widget.selectdoctor),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            if(!snapshot.hasData || snapshot.data!.isEmpty){
              return Center(child: Text("No Doctor Category Found"),);
            }
            var doctorcategory = snapshot.data!;
           return ListView.builder(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
              itemCount: doctorcategory.length,
              itemBuilder:(context,index){
                var item = doctorcategory[index];
               return GestureDetector(
                 onTap: (){

                   Get.to(DoctorDetail(doctordata: item,));
                 },
                 child: Card(

                    elevation: 3,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1,color: Colors.blue)
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Padding(padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Image.asset("assets/images/avatardoctorpreview.png")
                          ),
                          SizedBox(width: 16,),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"] ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                item["category"] ?? "",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],)),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
               );
              }

            );

          }
        ),
      ),
    );
  }
}
