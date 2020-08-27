import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;

  Future<String> get username async {
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(user.uid).get();

    return snapshot.data()['username'];
  }

  registerUsername(String username) {
    Map<String, String> dictionary = {"username": username};

    firestore.collection('users').doc(user.uid).set(dictionary);
  }
}
