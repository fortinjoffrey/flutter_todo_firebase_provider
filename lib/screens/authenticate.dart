import 'package:flutter/material.dart';
import 'package:todo_provider/mixins/auth_delegate.dart';
import 'package:todo_provider/screens/sign_in.dart';
import 'package:todo_provider/screens/sign_up.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> with AuthDelegate {
  bool showSignInScreen = true;

  @override
  Widget build(BuildContext context) {
    return showSignInScreen ? SignIn(delegate: this) : SignUp(delegate: this);
  }

  @override
  void onSwitchToSignInPressed() {
    setState(() {
      showSignInScreen = true;
    });
  }

  @override
  void onSwitchToSignUpPressed() {
    setState(() {
      showSignInScreen = false;
    });
  }
}
