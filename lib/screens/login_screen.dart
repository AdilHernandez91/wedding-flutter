import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../scoped-models/main.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  final MainModel model;

  LoginScreen(this.model);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String _username;
  String _password;
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
                  _buildSubmitButton()
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

  RaisedButton _buildSubmitButton() {
    return RaisedButton(
      child: Text('Login'),
      textColor: Colors.white,
      onPressed: _onSubmit,
    );
  }

  void _onSubmit() async {
    if (!_formKey.currentState.validate()) return;

    pr.show();

    try {
      _formKey.currentState.save();
      await widget.model.logIn(_username, _password);
      await widget.model.getProfile();
      pr.hide();
      Navigator.pushReplacementNamed(context, '/home');
    } catch (err) {
      pr.hide();
      _handleError('Username or password is incorrect');
    }
  }

  Future<void> _handleError(String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login failed'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}