import 'package:flutter/material.dart';

import 'user.dart';

class Guest {
  final String firstName;
  final String lastName;
  final String genre;
  final String allergens;
  final bool isChild;
  final bool isVegetarian;
  final User user;

  Guest({
    @required this.firstName,
    @required this.lastName,
    @required this.genre,
    this.allergens,
    @required this.isChild,
    @required this.isVegetarian,
    @required this.user
  });
}