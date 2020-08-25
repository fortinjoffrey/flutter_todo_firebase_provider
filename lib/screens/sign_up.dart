import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
  fillColor: Colors.white,
  filled: true,
  border: const OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(36.0)),
  ),
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(const Radius.circular(36.0)),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  focusedBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(const Radius.circular(36.0)),
    borderSide: BorderSide(color: Colors.blue, width: 1.0),
  ),
);

const backgroundLinearGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.1, 0.4, 0.7, 0.9],
  colors: [
    Color(0xFF3594DD),
    Color(0xFF4563DB),
    Color(0xFF5036D5),
    Color(0xFF5B16D0),
  ],
);

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String username = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: backgroundLinearGradient,
        ),
        // decoration: ,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildLogoSignUpTextRow(),
                    SizedBox(height: 16.0),
                    _buildEmailInput(),
                    SizedBox(height: 16.0),
                    _buildUsernameInput(),
                    SizedBox(height: 16.0),
                    _buildPasswordInput(),
                    SizedBox(height: 16.0),
                    _buildSignUpButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildLogoSignUpTextRow() {
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
            "Sign Up",
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

  ButtonTheme _buildSignUpButton() {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 50,
      child: RaisedButton(
        onPressed: () {},
        child: Text(
          'Sign Up',
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

  TextFormField _buildPasswordInput() {
    return TextFormField(
      decoration: textInputDecoration.copyWith(hintText: "Password"),
      obscureText: true,
    );
  }

  TextFormField _buildUsernameInput() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: textInputDecoration.copyWith(hintText: "Username"),
    );
  }

  TextFormField _buildEmailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: textInputDecoration.copyWith(hintText: "Email"),
    );
  }
}