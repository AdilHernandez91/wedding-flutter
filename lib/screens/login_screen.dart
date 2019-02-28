import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../scoped-models/main.dart';

import '../utils/functions/common_functions.dart';
import '../widgets/login/username_widget.dart';
import '../widgets/login/password_widget.dart';
import '../widgets/login/submit_button_widget.dart';

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
                  UsernameWidget(_usernameFocus, _passwordFocus, _username),
                  SizedBox(height: 20.0,),
                  PasswordWidget(_passwordFocus, _password),
                  SizedBox(height: 40.0,),
                  SubmitButtonWidget(_onSubmit),
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