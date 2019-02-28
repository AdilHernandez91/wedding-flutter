import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import '../models/guest.dart';
import '../scoped-models/main.dart';

class GuestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GuestScreenState();
  }
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return FutureBuilder(
          future: model.fetchGuests(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

            return _buildGuestList(snapshot.data);
          },
        );
      },
    );
  }

  Widget _buildGuestList(List<Guest> guests) {
    return ListView.builder(
      itemCount: guests.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildGuestItem(guests[index]);
      },
    );
  }

  Widget _buildGuestItem(Guest guest) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(guest.firstName + ' ' + guest.lastName),
          ),
          Divider(),
        ],
      ),
    );
  }
}