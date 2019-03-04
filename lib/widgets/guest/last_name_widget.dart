import 'package:flutter/material.dart';

class LastNameWidget extends StatelessWidget {
  final FocusNode lastNameFocus;
  final String lastName;

  LastNameWidget(this.lastNameFocus, this.lastName);

  @override
  TextFormField build(BuildContext context) {
    return TextFormField(
      initialValue: lastName,
      focusNode: lastNameFocus,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Type last name',
        labelText: 'Last name',
      ),
      validator: (String lastName) {
        if (lastName.isEmpty) {
          return 'Last name field is required';
        }
      },
      onFieldSubmitted: (String lastName) {
        lastNameFocus.unfocus();
      },
      onSaved: (String lastName) {
        lastName = lastName;
      },
    );
  }
}