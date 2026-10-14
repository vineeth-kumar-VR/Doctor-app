import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
Future<User?> signupwithemailandpassword(String email, String password)async{
try{
  UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  return userCredential.user;
}
catch(e){
  print("error $e");
  return null;
}
}

Future<User?>login(String email, String password)async{
try{
  UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
return userCredential.user;
}
catch(e){
  print("Login error: $e");
  return null;
}
}
}