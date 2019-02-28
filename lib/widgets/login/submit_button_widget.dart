import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';

class SubmitButtonWidget extends StatelessWidget {
  final Function onSubmit;

  SubmitButtonWidget(this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('Login'),
          textColor: Colors.white,
          onPressed: () => onSubmit(model),
        );
      },
    );
  }
}