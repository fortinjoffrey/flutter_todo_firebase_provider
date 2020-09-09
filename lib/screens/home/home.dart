import 'package:flutter/material.dart';
import 'package:todo_provider/mixins/todo_delegate.dart';
import 'package:todo_provider/models/todo.dart';
import 'package:todo_provider/screens/home/add_todo_modal_bottom_sheet.dart';

import 'package:todo_provider/services/firebase/firebase_auth_services.dart';
import 'package:todo_provider/services/firebase/firebase_firestore_services.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TodoDelegate {
  final List<Todo> todos = [
    Todo(title: 'First'),
    Todo(title: 'Second'),
    Todo(title: 'Third'),
  ];

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
                          child: AddToDoModalBottomSheet(delegate: this),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.add),
                ),
                body: SafeArea(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(todos[index].title),
                        ),
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

  @override
  void onSubmitTodo(Todo todo) {
    setState(() {
      todos.insert(0, todo);
    });
  }
}
