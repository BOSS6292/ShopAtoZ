import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<bool> loginAdmin(String email, String password) async{
    final credentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credentials.user != null;
  }

  static Future<void> logOut(){
    return _auth.signOut();
  }
}