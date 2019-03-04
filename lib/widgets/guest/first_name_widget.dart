import 'package:flutter/material.dart';

class FirstNameWidget extends StatelessWidget {
  final FocusNode firstNameFocus;
  final FocusNode nextFocus;
  final String firstName;

  FirstNameWidget(this.firstNameFocus, this.nextFocus, this.firstName);

  @override
  TextFormField build(BuildContext context) {
    return TextFormField(
      initialValue: firstName,
      focusNode: firstNameFocus,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Type first name',
        labelText: 'First name',
      ),
      validator: (String firstName) {
        if (firstName.isEmpty) {
          return 'First name field is required';
        }
      },
      onFieldSubmitted: (String firstName) {
        FocusScope.of(context).requestFocus(nextFocus);
      },
      onSaved: (String firstName) {
        firstName = firstName;
      },
    );
  }
}