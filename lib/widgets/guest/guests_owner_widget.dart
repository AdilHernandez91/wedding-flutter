import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';
import 'guest_list_widget.dart';
import '../../screens/guest_add_screen.dart';

class GuestsOwnerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GuestsOwnerWidgetState();
  }
}
class _GuestsOwnerWidgetState extends State<GuestsOwnerWidget> {
  @override
  void initState() {
    super.initState();

    MainModel model =ScopedModel.of(context);
    model.fetchOwnGuests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          if (model.isLoading) 
            return Center(child: CircularProgressIndicator());

          return GuestListWidget(model.allGuests, true);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return GuestAddScreen();
            },
            fullscreenDialog: true,
          ));
        },
      ),
    );
  }
}   