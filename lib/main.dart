import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'routes.dart';
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
    if (_model.getToken() != null) {
       _model.getProfile()
        .then((response) {
          setState(() => _isAuthenticated = true);
        })
        .catchError((err) {
          setState(() => _isAuthenticated = false);
        });
    } else {
      setState(() => _isAuthenticated = false);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: 'WeddingApp',
        theme: buildAppTheme(),
        initialRoute: '/LoginScreen',
        routes: routes,
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            );
          } else {
            return MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            );
          }
        },
      ),
    );
  }
}