import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/pages/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteDoctorPage extends StatefulWidget {
  const FavouriteDoctorPage({super.key});

  @override
  State<FavouriteDoctorPage> createState() => _FavouriteDoctorPageState();
}

class _FavouriteDoctorPageState extends State<FavouriteDoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Favourite Doctors"),
        backgroundColor: appbarcolor,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => ProfilePage());
          },
        ),
      ),
      body: StreamBuilder(stream: Firestore().fetchfavdoctor(), builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Text("No Favourite Doctor");
        }
        var data = snapshot.data!;
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context,index){
              var item = data[index];
              return Card(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: ListTile(
                  leading: Icon(Icons.person_2_outlined,size: 30,color: Colors.blue,),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date: ${item['name'] ?? ''}",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("Time: ${item['category'] ?? ''}",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("Gender: ${item['experience'] ?? ''}",style: TextStyle(fontWeight: FontWeight.bold),),

                    ],
                  ),
                ),
              );

        });
      })
    );
  }
}
