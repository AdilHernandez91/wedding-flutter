import 'package:flutter/material.dart';

class Guest {
  final int id;
  final String firstName;
  final String lastName;
  final bool isChild;
  final bool isVegetarian;
  final String genre;
  final String allergens;

  Guest({
    this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.genre,
    @required this.isVegetarian,
    this.allergens,
    this.isChild,
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
    );
  }
}