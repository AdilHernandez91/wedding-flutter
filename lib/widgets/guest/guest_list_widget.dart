import 'package:flutter/material.dart';

import '../../models/guest.dart';
import 'guest_item_widget.dart';
import 'guest_owner_widget.dart';

class GuestListWidget extends StatelessWidget {
  final List<Guest> guests;
  final bool isAdmin;

  GuestListWidget(this.guests, this.isAdmin);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: guests.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildGuestItem(isAdmin, guests[index]);
      },
    );
  }

  Widget _buildGuestItem(bool isAdmin, Guest guest) {
    if (isAdmin) {
      return GuestOwnerWidget(guest);
    }

    return GuestItemWidget(guest);
  }
}