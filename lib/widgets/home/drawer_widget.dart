import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final user = model.currentUser;

        return Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(user.username),
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