import 'package:flutter/material.dart';

import 'package:todo_provider/services/firebase_auth_services.dart';
import 'package:todo_provider/services/firebase_firestore_services.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestoreServices().username,
          builder: (context, snapshot) {
            bool isDone = snapshot.connectionState == ConnectionState.done;

            if (!isDone) return Center(child: CircularProgressIndicator());

            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Home'),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        FirebaseAuthServices().signOut();
                      },
                    )
                  ],
                ),
                resizeToAvoidBottomInset: false,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                      ),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AddToDoModalBottomSheet(),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.add),
                ),
                body: SafeArea(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Test'),
                      );
                    },
                  ),
                ),
              );
            }

            return Center(
              child: RaisedButton(
                onPressed: () async {
                  await FirebaseAuthServices().signOut();
                },
                child: Text('Something went wrong. Please sign out'),
              ),
            );
          }),
    );
  }
}

class AddToDoModalBottomSheet extends StatefulWidget {
  const AddToDoModalBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  _AddToDoModalBottomSheetState createState() =>
      _AddToDoModalBottomSheetState();
}

class _AddToDoModalBottomSheetState extends State<AddToDoModalBottomSheet> {
  final _formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.cyan,
        ),
        height: MediaQuery.of(context).size.height / 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Add an item",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                key: _formKey,
                validator: (value) => value.isEmpty ? 'Enter' : null,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                  fillColor: Colors.white,
                  hintText: 'Name',
                  filled: true,
                  border: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print('hello');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
