import 'package:flutter/material.dart';

import 'user.dart';

class Invitation {
  final String status;
  final String observations;
  final User user;

  Invitation({
    @required this.status,
    this.observations,
    @required this.user
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      status: json['status'],
      observations: json['observations'],
      user: json['user']
    );
  }
}