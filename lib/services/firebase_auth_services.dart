import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_provider/services/firebase_firestore_services.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User> get user {
    return auth.authStateChanges();
  }

  Future signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> signInWithEmailAndPassword({
    @required String email,
    @required String password,
    ValueChanged<String> onError,
    VoidCallback onSuccess,
  }) async {
    assert(email != null);
    assert(password != null);

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      String err;
      if (e.code == 'user-not-found') {
        err = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        err = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        err = 'The email address is badly formatted.';
      } else if (e.code == 'user-disabled') {
        err = 'User corresponding to the given email has been disabled.';
      }

      onError(err);
    } catch (e) {
      onError(e.toString());
    }
    return null;
  }

  Future<User> createUserWithEmailPasswordUsername({
    @required String email,
    @required String password,
    @required String username,
    ValueChanged<String> onError,
    VoidCallback onSuccess,
  }) async {
    assert(email != null);
    assert(password != null);

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      onSuccess();
      User user = userCredential.user;

      FirebaseFirestoreServices().registerUsername(username);

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
