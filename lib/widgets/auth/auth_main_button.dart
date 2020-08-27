import 'package:flutter/material.dart';

class AuthMainButton extends StatelessWidget {
  const AuthMainButton({
    Key key,
    @required this.onPressed,
    @required this.title,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 50,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(36.0)),
      ),
    );
  }
}
