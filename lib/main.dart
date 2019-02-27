import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scoped-models/main.dart';
import 'models/user.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

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
    if (_model.token != null) _fetchCurrentUser();

    if (_model.currentUser != null) {
      setState(() => _isAuthenticated = true);
    } else {
      setState(() => _isAuthenticated = false);
    }

    super.initState();
  }

  void _fetchCurrentUser() async {
    await _model.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'WeddingApp',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          buttonColor: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) =>
            _isAuthenticated ? HomeScreen(_model) : LoginScreen(_model),
          '/home': (BuildContext context) => HomeScreen(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(_model),
            );
          }
        },
      ),
    );
  }
}