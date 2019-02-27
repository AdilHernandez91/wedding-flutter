import 'package:flutter/material.dart';

import 'user.dart';

class Invitation {
  final String status;
  final String observations;
  final User user;

  Invitation({
    @required this.status,
    this.observations,
    this.user
  });
}