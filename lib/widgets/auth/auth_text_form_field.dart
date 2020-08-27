import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum AuthTextFormFieldType {
  Email,
  Username,
  Password,
}

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({
    Key key,
    this.hintText,
    @required this.type,
    @required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final AuthTextFormFieldType type;
  final ValueChanged<String> onChanged;

  static const textInputDecoration = InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: getTextInputType(),
      decoration:
          textInputDecoration.copyWith(hintText: hintText ?? getHintText()),
      onChanged: onChanged,
      validator: (value) => getValidator(value),
    );
  }

  String getHintText() {
    switch (type) {
      case AuthTextFormFieldType.Email:
        return 'Email';
        break;
      case AuthTextFormFieldType.Username:
        return 'Username';
        break;
      case AuthTextFormFieldType.Password:
        return 'Password';
        break;
      default:
        return '';
    }
  }

  String getValidator(String value) {
    switch (type) {
      case AuthTextFormFieldType.Email:
        return value.isEmpty ? 'Enter an email' : null;
        break;
      case AuthTextFormFieldType.Username:
        return value.isEmpty ? 'Enter a username' : null;
        break;
      case AuthTextFormFieldType.Password:
        return value.length < 6 ? 'Enter a password 6+ chars long' : null;
        break;
      default:
        return null;
    }
  }

  TextInputType getTextInputType() {
    switch (type) {
      case AuthTextFormFieldType.Email:
        return TextInputType.emailAddress;
        break;
      case AuthTextFormFieldType.Username:
        return TextInputType.name;
        break;
      case AuthTextFormFieldType.Password:
        return TextInputType.text;
        break;
      default:
        return TextInputType.text;
    }
  }
}

//   TextFormField _buildPasswordInput() {
//     return TextFormField(
//       decoration: textInputDecoration.copyWith(hintText: "Password"),
//       obscureText: true,
//       validator: (val) =>
//           val.length < 6 ? 'Enter a password 6+ chars long' : null,
//       onChanged: (value) => setState(() => password = value),
//     );
//   }

//   TextFormField _buildEmailInput() {
//     return TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       decoration: textInputDecoration.copyWith(hintText: "Email"),
//       validator: (val) => val.isEmpty ? 'Enter an email' : null,
//       onChanged: (value) => setState(() => email = value),
//     );
//   }
// }
