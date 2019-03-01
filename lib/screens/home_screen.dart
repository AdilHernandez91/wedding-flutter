import 'package:flutter/material.dart';

import '../widgets/home/bottom_navigation _widget.dart';

import 'invitation_screen.dart';
import 'blog_screen.dart';
import 'guest_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    BlogScreen(),
    GuestScreen(),
    InvitationScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationWidget(_currentIndex, _onTabTapped)
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}