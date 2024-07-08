import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_a_z/db/db_helper.dart';

class AuthService{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;

  static Future<bool> loginAdmin(String email, String password) async{
    final credentials = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return DbHelper.isAdmin(credentials.user!.uid);
  }

  static Future<void> logOut(){
    return _auth.signOut();
  }
}