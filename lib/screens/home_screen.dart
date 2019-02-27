import 'package:flutter/material.dart';

import '../scoped-models/main.dart';

class HomeScreen extends StatefulWidget {
  final MainModel model;

  HomeScreen(this.model);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text(widget.model.currentUser.username),),
    );
  }
}