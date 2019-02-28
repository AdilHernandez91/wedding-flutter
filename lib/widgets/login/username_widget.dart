import 'package:flutter/material.dart';

class UsernameWidget extends StatelessWidget {
  final FocusNode usernameFocus;
  final FocusNode nextFocus;
  final String username;

  UsernameWidget(this.usernameFocus, this.nextFocus, this.username);

  @override
  TextFormField build(BuildContext context) {
    return TextFormField(
      initialValue: 'nito',
      focusNode: usernameFocus,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Type your username',
        labelText: 'Username',
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
      ),
      validator: (String username) {
        if (username.isEmpty) {
          return 'Username is required';
        }
      },
      onFieldSubmitted: (String username) {
        FocusScope.of(context).requestFocus(nextFocus);
      },
      onSaved: (String username) {
        username = username;
      },
    );
  }
}