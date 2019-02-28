import 'package:flutter/material.dart';

class Guest {
  final int id;
  final String firstName;
  final String lastName;

  Guest({
    this.id,
    @required this.firstName,
    @required this.lastName,
  });

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}