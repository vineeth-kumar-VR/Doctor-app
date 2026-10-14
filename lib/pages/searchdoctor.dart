import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/database/firestore.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:doctorapp/pages/allcategoryfetch.dart';
import 'package:doctorapp/pages/particularcategorysearchfetch.dart';
import 'package:doctorapp/widgets/textfield.dart';
import 'package:flutter/material.dart';

class SearchDoctor extends StatefulWidget {
  const SearchDoctor({super.key});

  @override
  State<SearchDoctor> createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  String searchtext = "";
  final TextEditingController searchcontroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.blue,
        leading: arrowback,
        title: Text("Search Doctors Here", style: TextStyle(
        color: Colors.white,
        fontSize: 22,
          fontWeight: FontWeight.bold
      ),),),
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
          children: [
              TextInputField(
onchanged: (value){
setState(() {
searchtext = value.trim();
});
},
                      hinttext: "Search Doctors", prefixicon: Icons.search, controller: searchcontroler,

                  ),

            SizedBox(
              height: 20,
            ),
           Expanded(child: searchtext.isEmpty?AllCategoryFetch():ParticularCategorySearchFetch(category: searchcontroler.text.trim())
           )
          ],
        ),

    );
  }
}
