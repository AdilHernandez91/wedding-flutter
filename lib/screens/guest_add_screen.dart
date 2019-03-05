import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../models/guest.dart';

class GuestAddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GuestAddScreenState();
  }
}

class _GuestAddScreenState extends State<GuestAddScreen> {
  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _allergensFocus =FocusNode();
  final List<String> genres = ['Male', 'Female'];

  String _firstName;
  String _lastName;
  String _genre = 'Male';
  bool _isChild = false;
  bool _isVegetarian = false;
  String _allergens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Guest')),
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());

          return Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildFirstNameField(),
                    _buildLastNameField(),
                    _buildAllergensField(),
                    Padding(padding: EdgeInsets.only(top: 25.0),),
                    _buildGenreField(),
                    Padding(padding: EdgeInsets.only(top: 15.0),),
                    _buildChildField(),
                    Padding(padding: EdgeInsets.only(top: 10.0),),
                    _buildVegetarianField(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _buildSubmitButton(),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () => _onSubmit(model),
        );
      },
    );
  }

  TextFormField _buildLastNameField() {
    return TextFormField(
      focusNode: _lastNameFocus,
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
        _lastNameFocus.unfocus();
      },
      onSaved: (String lastName) {
        _lastName = lastName;
      },
    );
  }

  Widget _buildVegetarianField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: _isVegetarian,
          onChanged: (bool value) {
            setState(() => _isVegetarian = value);
          }
        ),
        Text('Are the guest vegetarian/vegan?')
      ],
    );
  }

  TextFormField _buildAllergensField() {
   return TextFormField(
      maxLines: 4,
      focusNode: _allergensFocus,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Allergens...',
        labelText: 'Allergens',
      ),
      onFieldSubmitted: (String firstName) {
        _allergensFocus.unfocus();
      },
      onSaved: (String allergens) {
        _allergens = allergens;
      },
    );
  }

  TextFormField _buildFirstNameField() {
    return TextFormField(
      focusNode: _firstNameFocus,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: 'Type first name',
        labelText: 'First name',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'First name field is required';
        }
      },
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(_lastNameFocus);
      },
      onSaved: (String value) {
        _firstName = value;
      },
    );
  }

  Widget _buildChildField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Checkbox(
          value: _isChild,
          onChanged: (bool value) {
            setState(() => _isChild = value);
          },
        ),
        Text('Are the guest under 12 years old?')
      ],
    );
  }

  DropdownButton _buildGenreField() {
    return DropdownButton(
      isExpanded: true,
      hint: Text('Select a genre'),
      value: _genre,
      onChanged: (value) => {
        setState(() => _genre = value),
      },
      items: genres.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _onSubmit(MainModel model) {
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    Guest guestToAdd = Guest(
      firstName: _firstName,
      lastName: _lastName,
      genre: _genre,
      isChild: _isChild,
      isVegetarian: _isVegetarian,
      allergens: _allergens
    ); 

    model.addGuest(guestToAdd).then((response) {
      Navigator.of(context).pop();
    }).catchError((err) {
      print('Error');
      print(err);
    });
  }
}