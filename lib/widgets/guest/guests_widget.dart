import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';
import 'guest_list_widget.dart';

class GuestsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return FutureBuilder(
          future: model.fetchGuests(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) 
              return Center(child: CircularProgressIndicator());

            return GuestListWidget(snapshot.data, false);
          },
        );
      },
    );
  }
}