import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/guest.dart';
import '../../scoped-models/main.dart';
import 'guest_item_widget.dart';

class GuestOwnerWidget extends StatelessWidget {
  final Guest guest;

  GuestOwnerWidget(this.guest);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Slidable(
          delegate: SlidableDrawerDelegate(),
          actionExtentRatio: 0.25,
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                GuestItemWidget(guest),
              ],
            )
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              icon: Icons.delete,
              onTap: () => _onDismiss(model, guest.id, context),
            ),
            IconSlideAction(
              color: Colors.white,
              caption: 'Edit',
              icon: Icons.edit,
              onTap: () => {},
            )
          ],
        ); 
      }
    );
  }

  void _onDismiss(MainModel model, int guestId, BuildContext context)  {
    model.deleteGuest(guestId);

    Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Guest deleted'),));
  }
}