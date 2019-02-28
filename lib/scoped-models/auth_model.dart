import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

const String API_URL = 'https://wedding-app-dev.herokuapp.com/api';

mixin AuthModel on Model {
  User _currentUser;

  User get currentUser => _currentUser;

  void authenticate(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    notifyListeners();
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }

  Future<void> logIn(String username, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await http.post('$API_URL/login/', body: {
      'username': username,
      'password': password,
    });

    final responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      preferences.setString('token', responseJson['token']);
      notifyListeners();
    } else {
      throw Exception(responseJson);
    }
  }

  Future<void> getProfile() async {
    final String token = await getToken();

    if (token != null) {
      final response = await http.get('$API_URL/auth/user/', headers: {
        HttpHeaders.authorizationHeader: 'Token ' + token
      });

      final responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        _currentUser = User.fromJson(responseJson);
        notifyListeners();
      } else {
        throw Exception(responseJson);
      }
    }
  }
}