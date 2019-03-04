import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../widgets/guest/first_name_widget.dart';
import '../widgets/guest/last_name_widget.dart';

class GuestEditScreen extends StatefulWidget {
  final int guestId;

  GuestEditScreen(this.guestId);

  @override
  State<StatefulWidget> createState() {
    return _GuestEditScreenState();
  }
}

class _GuestEditScreenState extends State<GuestEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus =FocusNode();

  @override
  void initState() {
    super.initState();
    
    MainModel model =ScopedModel.of(context);
    model.getGuestById(widget.guestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Guest'),
      ),
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator(),);
          return Container(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FirstNameWidget(
                      _firstNameFocus, _lastNameFocus, model.guestSelected.firstName),
                    LastNameWidget(
                      _lastNameFocus, model.guestSelected.lastName),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}