import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String _userID = '';
  String _avatarUrl = '';
  String _username = '';
  String _email = '';

  String get userID => _userID;
  String get avatarUrl => _avatarUrl;
  String get username => _username;
  String get email => _email;

  Future<void> loadUserInfo() async {
    _userID = await _storage.read(key: 'userID') ?? '';
    _email = await _storage.read(key: 'email') ?? '';
    _avatarUrl = await _storage.read(key: 'avatar') ?? '';
    _username = await _storage.read(key: 'username') ?? '';
    notifyListeners();
  }

  Future<void> setUserInfo(
      String userID, String email, String avatar, String username) async {
    await _storage.write(key: 'userID', value: userID);
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'avatar', value: avatar);
    await _storage.write(key: 'username', value: username);
    notifyListeners();
  }

  Future<bool> updateProfile(String userID, String name, String username,
      String email, String phone_number, String password) async {
    final url =
        'http://localhost:8000/api/auth/edit'; // Replace with your actual API endpoint

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userID': userID,
        'name': name,
        'username': username,
        'email': email,
        'password': password, // Ensure the password is hashed on the server
        'phone_number':
            phone_number, // Add phone number or replace with a form field
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // You can update the user data in the local storage if needed
      setUserInfo(userID!, email, _avatarUrl, username);
      return true; // Profile updated successfully
    } else {
      return false; // Error occurred
    }
  }

  Future<void> clearUserInfo() async {
    await _storage.delete(key: 'authToken');
    await _storage.delete(key: 'userID');
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'avatarUrl');
    await _storage.delete(key: 'username');
    _avatarUrl = '';
    _username = '';
    notifyListeners();
  }
}
