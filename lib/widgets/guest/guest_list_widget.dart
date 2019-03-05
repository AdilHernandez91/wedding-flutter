import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';
import '../../models/guest.dart';
import 'guest_item_widget.dart';

class GuestListWidget extends StatelessWidget {
  final List<Guest> guests;
  final bool isAdmin;

  GuestListWidget(this.guests, this.isAdmin);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> _refreshKey =      GlobalKey<RefreshIndicatorState>();

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RefreshIndicator(
          key: _refreshKey,
          onRefresh: () {
            isAdmin ? model.fetchOwnGuests() : model.fetchGuests();
          },
          child: ListView.builder(
            itemCount: guests.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildGuestItem(isAdmin, guests[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildGuestItem(bool isAdmin, Guest guest) {
    return GuestItemWidget(guest, isAdmin);
  }
}