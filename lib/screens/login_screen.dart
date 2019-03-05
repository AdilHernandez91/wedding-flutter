import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

import '../utils/functions/common_functions.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String _username = 'nito'; // For testing purposes
  String _password = 'deadsoul696'; // For testing purposes
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.setMessage('Logging in');
    
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 30.0),
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildUsernameField(),
                  SizedBox(height: 20.0,),
                  _buildPasswordField(),
                  SizedBox(height: 40.0,),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        )
      )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text('WeddingApp', style: TextStyle(color: Colors.black),),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('Login'),
          textColor: Colors.white,
          onPressed: () => _onSubmit(model),
        );
      },
    );
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.6),
        BlendMode.dstATop,
      ),
      image: AssetImage('assets/images/landing-image.jpg')
    );
  }

  TextFormField _buildUsernameField() {
    return TextFormField(
      initialValue: 'nito',
      focusNode: _usernameFocus,
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
        FocusScope.of(context).requestFocus(_passwordFocus);
      },
      onSaved: (String username) {
        _username = username;
      },
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      initialValue: 'deadsoul696',
      focusNode: _passwordFocus,
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
        _passwordFocus.unfocus();
      },
      onSaved: (String password) {
        _password = password;
      },
    );
  }

  void _onSubmit(MainModel model) async {
    if (!_formKey.currentState.validate()) return;

    pr.show();

    try {
      _formKey.currentState.save();

      await model.logIn(_username, _password);
      await model.getProfile();

      pr.hide();
      Navigator.pushReplacementNamed(context, '/HomeScreen');
    } catch (err) {
      pr.hide();
      errorDialog(context, 'Login failed', 'Username or password is incorrect');
    }
  }
}