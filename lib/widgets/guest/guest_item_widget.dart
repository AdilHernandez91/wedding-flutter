import 'package:flutter/material.dart';

import '../../models/guest.dart';

class GuestItemWidget extends StatelessWidget {
  final Guest guest;

  GuestItemWidget(this.guest);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text(guest.firstName + ' ' + guest.lastName),
          ),
          Divider(),
        ],
      ),
    );
  }
}