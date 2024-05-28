import 'dart:convert';

import 'package:agazh/domain/auth/user_model.dart';
import 'package:http/http.dart';

const String baseUrl = 'http://127.0.0.1:8000';

class AuthDataSource {
  Future<String> login(String username, String password) async {
    var request = Request('POST', Uri.parse('$baseUrl/token/'));

    request.body = jsonEncode({'username': username, 'password': password});
    request.headers['Content-Type'] = 'application/json';

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var token = jsonDecode(body)['access'];
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> register(
      String username, String email, String password, Role role) async {
    var request = Request('POST', Uri.parse('$baseUrl/signup/'));
    request.headers['Content-Type'] = 'application/json';

    request.body = jsonEncode({
      'username': username,
      'email': email,
      'password': password,
      'role': role == Role.client ? 'client' : 'freelancer'
    });

    var response = await request.send();

    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }

  Future<User> getMe(String token) async {
    var request = Request('POST', Uri.parse('$baseUrl/me/'));
    request.headers['Authorization'] = 'Bearer $token';

    var response = await request.send();
    var body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      var user = jsonDecode(body);
      return User.fromJson(user);
    } else {
      throw Exception('Failed to get user');
    }
  }
}
