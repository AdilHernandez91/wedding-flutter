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

    final responseGuest = await http.get('$API_URL/guests/feed/', headers: {
      HttpHeaders.authorizationHeader: 'Token ' + token
    });

    final responseUser = await http.get('$API_URL/users/', headers: {
      HttpHeaders.authorizationHeader: 'Token ' + token
    });

    final List<dynamic> responseUserJson = json.decode(responseUser.body);
    final List<dynamic> responseGuestJson = json.decode(responseGuest.body);

    if (responseGuest.statusCode == 200 && responseUser.statusCode == 200) {
      responseGuestJson.forEach((guest) {
        guests.add(Guest.fromJson(guest));
      });

      responseUserJson.forEach((user) {
        guests.add(Guest.fromJson(user));
      });

      return guests;
    } else {
      throw Exception('Failed fetching guests');
    }
  }

  Future<List<Guest>> fetchOwnGuests() async {
    List<Guest> guests = [];
    String token = await getToken();

    final response = await http.get('$API_URL/guests/', headers: {
      HttpHeaders.authorizationHeader: 'Token ' + token
    });

    final List<dynamic> responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      responseJson.forEach((guest) {
        guests.add(Guest.fromJson(guest));
      });

      return guests;
    } else {
      throw Exception('Failed fetching guests');
    }
  }

  Future<void> deleteGuest(int guestId) async {
    String token = await getToken();

    await http.delete('$API_URL/guests/$guestId/', headers: {
      HttpHeaders.authorizationHeader: 'Token ' + token
    });
  }
}