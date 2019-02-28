import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import 'auth_model.dart';
import '../models/guest.dart';

const String API_URL = 'https://wedding-app-dev.herokuapp.com/api';

mixin GuestModel on Model, AuthModel {
  Future<List<Guest>> fetchGuests() async {
    List<Guest> guests = [];
    String token = await getToken();

    final response = await http.get('$API_URL/guests/feed/', headers: {
      HttpHeaders.authorizationHeader: 'Token ' + token
    });

    final List<dynamic> responseJson =json.decode(response.body);


    if (response.statusCode == 200) {
      responseJson.forEach((guest) {
        guests.add(Guest.fromJson(guest));
      });

      return guests;
    } else {
      throw Exception('Failed fetching guests');
    }
  }
}