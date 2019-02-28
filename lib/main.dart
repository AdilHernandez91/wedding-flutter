import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scoped-models/main.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

import 'utils/theme.dart';

void main() => runApp(WeddingApp());

class WeddingApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeddingAppState();
  }
}

class _WeddingAppState extends State<WeddingApp> {
  MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _checkIfLodded()
      .then((response) {
        setState(() => _isAuthenticated = true);
      })
      .catchError((err) {
        setState(() => _isAuthenticated = false);
      });
      
    super.initState();
  }

  Future<void> _checkIfLodded() async {
    return await _model.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'WeddingApp',
        theme: buildAppTheme(),
        initialRoute: '/LoginScreen',
        routes: {
          '/LoginScreen': (BuildContext context) => 
            !_isAuthenticated ? LoginScreen() : HomeScreen(),
          '/HomeScreen': (BuildContext context) => HomeScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            );
          }
        },
      ),
    );
  }
}