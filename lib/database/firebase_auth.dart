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


  Future<User?> login(String email, String password) async {
    try {
      final userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      print('Login successful: ${userCredential.user?.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Firebase login error code: ${e.code}');
      print('Firebase login error message: ${e.message}');
      return null;
    } catch (e) {
      print('Unexpected login error: $e');
      return null;
    }
  }

}