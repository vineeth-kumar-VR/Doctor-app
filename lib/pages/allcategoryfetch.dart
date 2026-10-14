import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/pages/doctordetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoryFetch extends StatefulWidget {
  const AllCategoryFetch({super.key});

  @override
  State<AllCategoryFetch> createState() => _AllCategoryFetchState();
}

class _AllCategoryFetchState extends State<AllCategoryFetch> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Firestore().fetchcategory(), builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);
      }
      if(!snapshot.hasData || snapshot.data!.isEmpty){
        return Center(child: Text("No Category Found"),);
      }
      var data = snapshot.data!;
      return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,index){
        var item = data[index];
        return GestureDetector(
          onTap: (){
            Get.to(DoctorDetail(doctordata: item));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: Colors.blue)
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(padding: EdgeInsets.all(8),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                    AssetImage("assets/images/avatardoctorpreview.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          item["name"] ?? "Unknown",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          item["category"] ?? "Unknown",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),

                      ],
                    ),
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
    });
  }
}
