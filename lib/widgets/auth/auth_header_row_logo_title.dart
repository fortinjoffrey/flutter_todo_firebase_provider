import 'package:flutter/material.dart';

class AuthHeaderRowLogoTitle extends StatelessWidget {
  const AuthHeaderRowLogoTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: Image.asset(
            'assets/logos/firebase_logo.png',
            height: 150,
          ),
        ),
        Flexible(
          flex: 3,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
        )
      ],
    );
  }
}
