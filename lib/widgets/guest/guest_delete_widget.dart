import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';

class GuestDeleteWidget extends StatelessWidget {
  final int guestId;

  GuestDeleteWidget(this.guestId);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            model.deleteGuest(guestId);
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Guest successfully deleted'),
            ));
          }
        );
      },
    );
  }
}