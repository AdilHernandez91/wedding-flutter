import 'package:flutter/material.dart';

import '../widgets/home/drawer_widget.dart';
import '../widgets/guest/guests_widget.dart';
import '../widgets/guest/guests_owner_widget.dart';

class GuestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GuestScreenState();
  }
}

class _GuestScreenState extends State<GuestScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          title: Text('Guests'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.people),
                text: 'All guests',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'My guests',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            GuestsWidget(),
            GuestsOwnerWidget(),
          ],
        ),
      ),
    );
  }
}