import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/auth_pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class Firestore{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void>savessignupdata( {
   required String name, required String email,required String phone,required String uid
})async{
    try{
      await _firestore.collection("users").doc(uid).set({
        "name":name,
        "email":email,

        "phone":phone,
        "uid":uid,
        "time":FieldValue.serverTimestamp()
      });
    }
    catch(e){
      print("error$e");
    }
  }

  Future<bool> checkGoogleEmail(String email) async {
    try {
      final result = await _firestore
          .collection("users")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();

      return result.docs.isNotEmpty;
    } catch (e) {
      print("Google email check error: $e");
      return false;
    }
  }



  Stream<List<Map<String,dynamic>>>fetchdoctordetails(){
    return _firestore.collection("doctors").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        var data = doc.data();
        return{
          "id": doc.id,
          "name": data["name"] ?? "",
          "category": data["category"] ?? "",
          "about": data["about"] ?? "",
          "experience": data["experience"] ?? "",
          "language": data["language"] ?? [],
          "location": data["location"] ?? "",
          "rating": data["rating"] ?? "",
          "timeslots": data["timeslots"] ?? {},
          "weekcount": data["weekcount"] ?? [],
          "weekdays": data["weekdays"] ?? [],
        };
      }).toList();
    });

  }

  Stream<List<Map<String, dynamic>>> fetchdoctorcategory(String category) {
    final searchCategory = category.trim().toLowerCase();

    return _firestore
        .collection("doctors")
        .where("category", isEqualTo: searchCategory)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return {
          "id": doc.id,
          "name": data["name"],
          "category": data["category"],
          "about": data["about"],
          "experience": data["experience"],
          "location": data["location"],
          "rating": data["rating"],
          "language": data["language"],
          "timeslots": data["timeslots"],
          "weekdays": data["weekdays"],
          "weekcount": data["weekcount"],
        };
      }).toList();
    });
  }
  Future<void> bookappointment({
    required String doctorname,
    required String location,
    required String date,
    required String time,
    required String name,
    required String age,
    required String gender,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      print("========== SAVING APPOINTMENT ==========");
      print("USER UID: ${user?.uid}");
      print("USER PHONE: ${user?.phoneNumber}");

      if (user != null) {

        print("PATH: users/${user.uid}/appointments");

        await _firestore
            .collection("users")
            .doc(user.uid)
            .collection("appointments")
            .add({
          "doctor": doctorname,
          "location": location,
          "date": date,
          "time": time,
          "name": name,
          "age": age,
          "gender": gender,
          "created_at": FieldValue.serverTimestamp(),
        });

        print("========== APPOINTMENT SAVED ==========");
      }
    } catch (e) {
      print("ERROR SAVING APPOINTMENT: $e");
    }
  }
  Stream<List<Map<String, dynamic>>> fetchappointment() {
    final user = FirebaseAuth.instance.currentUser;

    print("CURRENT USER UID: ${user?.uid}");
    print("CURRENT USER PHONE: ${user?.phoneNumber}");
    print("CURRENT USER EMAIL: ${user?.email}");

    if (user != null) {
      return _firestore
          .collection("users")
          .doc(user.uid)
          .collection("appointments")
          .snapshots()
          .map((snapshot) {
        print("APPOINTMENT COUNT: ${snapshot.docs.length}");

        return snapshot.docs.map((doc) {
          var data = doc.data();
          data["id"] = doc.id;

          print("APPOINTMENT: $data");

          return data;
        }).toList();
      });
    }

    return Stream.empty();
  }
Stream<List<Map<String,dynamic>>>fetchappointmentdetails(String doctordata){
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      return _firestore.collection("users").doc(user.uid).collection("appointments").where("doctor",isEqualTo: doctordata).snapshots().map((snapshot)=>snapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList());
    }
    return Stream.empty();
    
}
Future<void>deleteappointment(String datadelete)async{
 final user = FirebaseAuth.instance.currentUser;
 if(user != null){
   try{
     final docref = await _firestore.collection("users").doc(user.uid).collection("appointments").doc(datadelete);
     final documentref =await docref.get();
     if(documentref.exists){
       await _firestore.collection("users").doc(user.uid).collection("deleteappointment").doc(datadelete).set(documentref.data()!);
       await docref.delete();

       print("Appointment moved to deleteappointments successfully");
     }
   }
   catch(e){
     print("Error moving appointment: $e");


   }

 }
}

Stream<List<Map<String,dynamic>>>fetchdeleteappointments(){
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return _firestore.collection("users").doc(user.uid).collection("deleteappointment").orderBy("date",descending: true).snapshots().map((snapshot)=>snapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList());
    }
    return Stream.empty();
}
  Stream<List<Map<String, dynamic>>> fetchDoctorNameAndCategory() {
    return _firestore.collection("doctors").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        print("🔥 Doctor Data: $data");
        return {
          "name": data["name"],
          "category": data["category"],
        };
      }).toList();
    });
  }
  Stream<List<Map<String, dynamic>>> fetchDoctorByCategory(String category) {
    final query = category.toLowerCase();
    return _firestore
        .collection("doctors")
        .orderBy("category")                          // required for startAt()
        .startAt([query])                             // partial search start
        .endAt([query + '\uf8ff'])
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          "id": doc.id,
          "name": data["name"],
          "category": data["category"],
          "about": data["about"],
          "experience": data["experience"],
          "location": data["location"],
          "rating": data["rating"],
          "language": data["language"],
          "timeslots": data["timeslots"],
          "weekdays": data["weekdays"],
          "weekcount": data["weekcount"],
        };
      }).toList();
    });
  }
  Stream<List<Map<String, dynamic>>> fetchcategory() {
    return _firestore.collection("doctors").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          "name": doc["name"] ?? "",
          "category": doc["category"] ?? "",
          "about": doc["about"] ?? "",
          "experience": doc["experience"] ?? "",
          "language": doc["language"] ?? [],
          "location": doc["location"] ?? "",
          "rating": doc["rating"] ?? "",
          "timeslots": doc["timeslots"] ?? {},
          "weekcount": doc["weekcount"] ?? [],
          "weekdays": doc["weekdays"] ?? [],
        };
      }).toList();
    });
  }

  Stream<Map<String, dynamic>?> fetchnamemail() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Stream.empty();
    }

    // Email login
    if (user.email != null) {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .snapshots()
          .map((doc) {
        if (doc.exists) {
          return doc.data();
        }
        return null;
      });
    }

    // Phone OTP login
    if (user.phoneNumber != null) {
      String phone = user.phoneNumber!;

      // Remove +91
      if (phone.startsWith("+91")) {
        phone = phone.substring(3);
      }

      return FirebaseFirestore.instance
          .collection("users")
          .where("phone", isEqualTo: phone)
          .limit(1)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return snapshot.docs.first.data();
        }

        return null;
      });
    }

    return Stream.value(null);
  }

Future<bool>updatenameemail(
  {
    required String name,
    required String email
}
    )async{
    final user = FirebaseAuth.instance.currentUser;
    try{
      if(user == null)return false;
      await _firestore.collection("users").doc(user.uid).update({
        "name":name,
        "email":email
      });
return true;
    }
    catch(e){
return false;
    }


}

Stream<List<Map<String,dynamic>>>fetchappointments(){
    final user = FirebaseAuth.instance.currentUser;
    if(user == null){
      return Stream.empty();
    }
    return _firestore.collection("users").doc(user.uid).collection("appointments").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return {
          "doc":doc.id,
          ...doc.data()
        };
      }).toList();
    });
}
Stream<List<Map<String,dynamic>>>fetchfavdoctor(){
    final user = FirebaseAuth.instance.currentUser;
    if (user == null){
      return Stream.empty();
    }
    return _firestore.collection("doctors").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return {
          "doc":doc.id,
          ...doc.data()
        };
      }).toList();
    });
}

Future<void>logout()async{
    await FirebaseAuth.instance.signOut();
    Get.offAll(()=>LoginPage());

}

}