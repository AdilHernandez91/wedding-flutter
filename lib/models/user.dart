import 'package:flutter/material.dart';

import 'types/genre.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final Genre genre;
  final String allergens;
  final bool isVegetarian;

  User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.username,
    @required this.genre,
    this.allergens,
    @required this.isVegetarian,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      genre: json['genre'],
      allergens: json['allergens'],
      isVegetarian: json['isVegetarian'],
    );
  }
}