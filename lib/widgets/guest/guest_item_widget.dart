import 'package:flutter/material.dart';

import '../../models/guest.dart';
import 'guest_delete_widget.dart';

class GuestItemWidget extends StatelessWidget {
  final Guest guest;
  final bool isAdmin;

  GuestItemWidget(this.guest, this.isAdmin);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            leading: Icon(
              Icons.supervised_user_circle,
              size: 32,
            ),
            title: Text(
              guest.firstName + ' ' + guest.lastName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            trailing: isAdmin ? GuestDeleteWidget(guest.id) : null,
          ),
          Divider(),
        ],
      ),
    );
  }
}