import 'package:flutter/material.dart';

import '../../models/guest.dart';
import 'guest_edit_widget.dart';

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
            leading: Icon(Icons.person_outline),
            title: Text(guest.firstName + ' ' + guest.lastName),
            trailing: isAdmin ? GuestEditWidget(guest.id) : null,
          ),
          Divider(),
        ],
      ),
    );
  }
}