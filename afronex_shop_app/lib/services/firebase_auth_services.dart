import 'package:afronex_shop_app/services/utils/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> _signUp(String username, String email, String password) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      showToast(message: 'Some Fields are Empty');
      return null;
    }
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      
    } catch (e) {}
    return null;
  }
}
