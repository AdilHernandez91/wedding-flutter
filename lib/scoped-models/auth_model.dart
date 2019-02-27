import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../models/user.dart';

const String API_URL = 'https://wedding-app-dev.herokuapp.com/api';

mixin AuthModel on Model {
  User _currentUser;
  String _token;

  User get currentUser => _currentUser;

  String get token => _token;

  void authenticate(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> logIn(String username, String password) async {
    final response = await http.post('$API_URL/login/', body: {
      'username': username,
      'password': password,
    });

    final responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      _token = responseJson['token'];
      
      notifyListeners();
    } else {
      throw Exception(responseJson);
    }
  }

  Future<void> getProfile() async {
    final response = await http.get('$API_URL/auth/user/', headers: {
      HttpHeaders.authorizationHeader: 'Token ' + _token
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