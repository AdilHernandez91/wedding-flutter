import 'package:flutter/material.dart';

import '../../screens/guest_edit_screen.dart';

class GuestEditWidget extends StatelessWidget {
  final int guestId;

  GuestEditWidget(this.guestId);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => GuestEditScreen(guestId),
        ));
      }
    );
  }
}