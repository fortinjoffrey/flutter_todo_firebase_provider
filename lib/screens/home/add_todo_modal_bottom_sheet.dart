import 'package:flutter/material.dart';
import 'package:todo_provider/mixins/todo_delegate.dart';
import 'package:todo_provider/models/todo.dart';

class AddToDoModalBottomSheet extends StatefulWidget {
  const AddToDoModalBottomSheet({
    Key key,
    this.delegate,
  }) : super(key: key);

  final TodoDelegate delegate;

  @override
  _AddToDoModalBottomSheetState createState() =>
      _AddToDoModalBottomSheetState();
}

class _AddToDoModalBottomSheetState extends State<AddToDoModalBottomSheet> {
  final _formKey = GlobalKey<FormFieldState>();

  String todoName = '';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height / 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
              _buildTitle(),
              SizedBox(height: 16.0),
              _buildTodoTextFormField(
                onChanged: (value) => todoName = value,
              ),
              SizedBox(height: 16.0),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  RaisedButton _buildSubmitButton(BuildContext context) {
    return RaisedButton(
      child: Text('Submit'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          if (widget.delegate != null) {
            Navigator.pop(context);
            widget.delegate.onSubmitTodo(Todo(title: todoName));
          }
        }
      },
    );
  }

  static const textInputDecoration = InputDecoration(
    hintText: 'Todo name',
    hintStyle: TextStyle(
      fontSize: 16,
      color: Colors.grey,
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
    fillColor: Color(0xFFF4FAFE),
    filled: true,
    border: const OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(const Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.white, width: 1.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(const Radius.circular(20.0)),
      borderSide: BorderSide(color: Colors.blue, width: 1.0),
    ),
  );

  TextFormField _buildTodoTextFormField({Function(String) onChanged}) {
    return TextFormField(
      key: _formKey,
      keyboardType: TextInputType.name,
      validator: (value) => value.isEmpty ? 'Field is empty' : null,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      decoration: textInputDecoration,
      onChanged: onChanged,
    );
  }

  Text _buildTitle() {
    return Text(
      "Add an item",
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
