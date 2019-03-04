import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';
import 'guest_list_widget.dart';

class GuestsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GuestsWidgetState();
  }
}
class _GuestsWidgetState extends State<GuestsWidget> {
  @override
  void initState() {
    super.initState();

    MainModel model = ScopedModel.of(context);
    model.fetchGuests();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.isLoading) return Center(child: CircularProgressIndicator(),);
        return GuestListWidget(model.allGuests, false);
      },
    );
  }
}