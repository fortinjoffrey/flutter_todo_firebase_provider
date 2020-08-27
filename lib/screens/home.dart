import 'package:flutter/material.dart';

import 'package:todo_provider/services/firebase_auth_services.dart';
import 'package:todo_provider/services/firebase_firestore_services.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: FirebaseFirestoreServices().username,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data),
                    RaisedButton(
                      onPressed: () async {
                        await FirebaseAuthServices().signOut();
                      },
                      child: Text('Sign Out'),
                    ),
                  ],
                );
              }

              if (snapshot.hasError) {
                print('Failed to fetch username');
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Something went wrong.'),
                  RaisedButton(
                    onPressed: () async {
                      await FirebaseAuthServices().signOut();
                    },
                    child: Text('Sign Out'),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
