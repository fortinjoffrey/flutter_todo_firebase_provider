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

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String username = '';
  String email = '';
  String password = '';
  String errorText = '';
  String successText = '';

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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildEmailInput(),
                          SizedBox(height: 16.0),
                          _buildPasswordInput(),
                          SizedBox(height: 16.0),
                          _buildSignInButton(),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    errorText != ''
                        ? Text(
                            errorText,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          )
                        : Text(
                            successText,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 14.0,
                            ),
                          ),
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
            "Sign In",
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

  void _sinInUser() async {
    // TODO: call a method to signInUser in Firebase Auth
    // await FirebaseAuthServices().createUserWithEmailAndPassword(
    //     email: email,
    //     password: password,
    //     onSuccess: () {
    //       setState(() {
    //         successText = 'Account created successfully';
    //         errorText = '';
    //       });
    //     },
    //     onError: (err) {
    //       setState(() {
    //         successText = '';
    //         errorText = err;
    //       });
    //     });
  }

  ButtonTheme _buildSignInButton() {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 50,
      child: RaisedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();

          if (_formKey.currentState.validate()) {
            _sinInUser();
          } else {
            // clean success and error message
            successText = '';
            errorText = '';
          }
        },
        child: Text(
          'Sign In',
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
      validator: (val) =>
          val.length < 6 ? 'Enter a password 6+ chars long' : null,
      onChanged: (value) => setState(() => password = value),
    );
  }

  TextFormField _buildEmailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: textInputDecoration.copyWith(hintText: "Email"),
      validator: (val) => val.isEmpty ? 'Enter an email' : null,
      onChanged: (value) => setState(() => email = value),
    );
  }
}
