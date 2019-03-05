import 'package:flutter/material.dart';

import '../models/user.dart';
import 'types/genre.dart';

class Guest {
  final int id;
  final String firstName;
  final String lastName;
  final bool isChild;
  final bool isVegetarian;
  final Genre genre;
  final String allergens;
  final User user;

  Guest({
    this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.genre,
    @required this.isVegetarian,
    @required this.allergens,
    this.isChild,
    this.user,
  });

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      genre: json['genre'],
      isVegetarian: json['isVegetarian'],
      allergens: json['allergens'],
      isChild: json['isChild'],
      user: json['user']
    );
  }
}