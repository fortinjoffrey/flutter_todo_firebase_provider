import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> createUserWithEmailAndPassword(
      {String email,
      String password,
      Function onSuccess,
      Function onError}) async {
    print("called");
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      onSuccess();
      return user;
    } on FirebaseAuthException catch (e) {
      String err;
      if (e.code == 'weak-password') {
        err = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        err = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        err = 'The email address is badly formatted.';
      }
      onError(err);
    } catch (e) {
      print(e.toString());
      onError(e.toString());
    }
    return null;
  }
}
