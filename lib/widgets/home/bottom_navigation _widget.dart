import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function onTabTapped;

  BottomNavigationWidget(this.currentIndex, this.onTabTapped);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Blog'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          title: Text('Guests'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text('My Invitation'),
        )
      ],
    );
  }
}