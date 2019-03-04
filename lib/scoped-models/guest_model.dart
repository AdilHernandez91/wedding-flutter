import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import 'auth_model.dart';
import '../models/guest.dart';

const String API_URL = 'https://wedding-app-dev.herokuapp.com/api';

mixin GuestModel on Model, AuthModel {
  List<Guest> _guests;
  Guest _guestSelected;
  bool _isLoading = false;

  List<Guest> get allGuests => _guests;

  bool get isLoading => _isLoading;

  Guest get guestSelected => _guestSelected;

  Future<void> fetchGuests() async {
    _guests = [];
    _isLoading = true;
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
        _guests.add(Guest.fromJson(guest));
      });

      responseUserJson.forEach((user) {
        _guests.add(Guest.fromJson(user));
      });

      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed fetching guests');
    }
  }

  Future<void> fetchOwnGuests() async {
    _guests = [];
    _isLoading = true;
    String token = await getToken();

    final response = await http.get('$API_URL/guests/', headers: {
      HttpHeaders.authorizationHeader: 'Token ' + token
    });

    final List<dynamic> responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      responseJson.forEach((guest) {
        _guests.add(Guest.fromJson(guest));
      });

       _isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed fetching guests');
    }
  }

  Future<void> deleteGuest(int guestId) async {
    String token = await getToken();

    await http.delete('$API_URL/guests/$guestId/', headers: {
      HttpHeaders.authorizationHeader: 'Token ' + token
    });

    fetchOwnGuests();
    notifyListeners();
  }

  Future<void> getGuestById(int guestId) async {
    _isLoading = true;
    String token = await getToken();

    final response = await http.get('$API_URL/guests/$guestId', headers: {
      HttpHeaders.authorizationHeader: 'Token ' + token
    });

    if (response.statusCode == 200) {
      _guestSelected =Guest.fromJson(json.decode(response.body));
      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed get guest');
    }
  }
}