import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  // final String baseUrl = 'http://10.0.2.2:8000/api';
  final String baseUrl = 'http://localhost:8000/api';
  final storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['token'];
      await storage.write(key: 'authToken', value: token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(
    String fullname,
    String username,
    String phone,
    String email,
    String password,
  ) async {
    print("register service called");
    print("data: $username, $fullname, $email, $phone, $password");

    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': fullname,
        'username': username,
        'phone_number': phone,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print("register successful");
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'authToken');
  }

  Future<String?> getToken() async {
    print("Getting token...");
    return await storage.read(key: 'authToken');
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final token = await getToken();
    if (token == null) {
      print("Token is null");
      return null;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/auth/showProfile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("User Info: ${json.decode(response.body)}");
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}
