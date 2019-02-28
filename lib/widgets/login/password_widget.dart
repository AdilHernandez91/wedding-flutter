import 'package:flutter/material.dart';

class PasswordWidget extends StatelessWidget {
  final FocusNode passwordFocus;
  final String password;

  PasswordWidget(this.passwordFocus, this.password);

  @override
  TextFormField build(BuildContext context) {
    return TextFormField(
      initialValue: 'deadsoul696',
      focusNode: passwordFocus,
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Type your password',
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
      ),
      validator: (String password) {
        if (password.isEmpty) {
          return 'Password is required';
        }
      },
      onFieldSubmitted: (String password) {
        passwordFocus.unfocus();
      },
      onSaved: (String password) {
        password = password;
      },
    );
  }
}