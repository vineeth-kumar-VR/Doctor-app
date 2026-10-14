import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/pages/doctordetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ParticularCategorySearchFetch extends StatefulWidget {
  final String category;
  const ParticularCategorySearchFetch({super.key,required this.category});

  @override
  State<ParticularCategorySearchFetch> createState() => _ParticularCategorySearchFetchState();
}

class _ParticularCategorySearchFetchState extends State<ParticularCategorySearchFetch> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Firestore().fetchDoctorByCategory(widget.category), builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(),);

      }
      if(!snapshot.hasData || snapshot.data!.isEmpty){
        return Center(child: Text("No Doctor Found"),);
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
                elevation: 0,
                margin: const EdgeInsets.all(4),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
                color: Theme.of(context).cardColor,
                child: Padding(padding: EdgeInsets.all(8),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                        AssetImage("assets/images/avatardoctorpreview.png"),
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
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
