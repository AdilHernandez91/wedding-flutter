import 'package:flutter/material.dart';

void errorDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Continue'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}

void deleteDialog(
  BuildContext context, String title, String content, Function onDelete
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.grey,
          ),
          FlatButton(
            child: Text('Confirm'),
            onPressed: () {},
          ),
        ],
      );
    }
  );
}