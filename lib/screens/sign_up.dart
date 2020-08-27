import 'package:flutter/material.dart';
import 'package:todo_provider/services/firebase_auth_services.dart';
import 'package:todo_provider/utils/linear_gradient_extension.dart';
import 'package:todo_provider/widgets/auth/auth_header_row_logo_title.dart';
import 'package:todo_provider/widgets/auth/auth_main_button.dart';
import 'package:todo_provider/widgets/auth/auth_text_form_field.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
          gradient: LinearGradientExtension.authBgGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AuthHeaderRowLogoTitle(title: 'Sign Up'),
                    SizedBox(height: 16.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildAuthTextFormField(AuthTextFormFieldType.Email),
                          SizedBox(height: 16.0),
                          _buildAuthTextFormField(
                              AuthTextFormFieldType.Username),
                          SizedBox(height: 16.0),
                          _buildAuthTextFormField(
                              AuthTextFormFieldType.Password),
                          SizedBox(height: 16.0),
                          AuthMainButton(
                            title: 'Sign Up',
                            onPressed: () {
                              _handleSignUpPressed(context);
                            },
                          ),
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

  AuthTextFormField _buildAuthTextFormField(AuthTextFormFieldType type) {
    return AuthTextFormField(
        type: type,
        onChanged: (value) {
          switch (type) {
            case AuthTextFormFieldType.Email:
              email = value;
              break;
            case AuthTextFormFieldType.Username:
              username = value;
              break;
            case AuthTextFormFieldType.Password:
              password = value;
              break;
            default:
              return '';
          }
        });
  }

  void _handleSignUpPressed(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      _createUser();
    } else {
      // clean success and error message
      successText = '';
      errorText = '';
    }
  }

  void _createUser() async {
    await FirebaseAuthServices().createUserWithEmailAndPassword(
        email: email,
        password: password,
        onSuccess: () {
          setState(() {
            successText = 'Account created successfully';
            errorText = '';
          });
        },
        onError: (err) {
          setState(() {
            successText = '';
            errorText = err;
          });
        });
  }
}
