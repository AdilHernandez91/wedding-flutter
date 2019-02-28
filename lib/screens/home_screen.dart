import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: _buildHomeDrawer(),
      body: Center(child: Text('Home Screen'),),
    );
  }

  Widget _buildHomeDrawer() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(model.currentUser.username),
                accountEmail: Text('User account'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(model.currentUser.username[0].toUpperCase()),
                ),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                 
                  Navigator.pushReplacementNamed(context, '/LoginScreen');
                   model.logOut();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}