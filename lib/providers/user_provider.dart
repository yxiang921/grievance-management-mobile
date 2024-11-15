import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  String _avatarUrl = '';
  String _username = '';

  String get avatarUrl => _avatarUrl;
  String get username => _username;

  Future<void> loadUserInfo() async {
    _avatarUrl = await _storage.read(key: 'avatar') ?? '';
    _username = await _storage.read(key: 'username') ?? '';
    notifyListeners();
  }

  Future<void> setUserInfo(String avatar, String username) async {
    await _storage.write(key: 'avatar', value: avatar);
    await _storage.write(key: 'username', value: username);
    notifyListeners();
  }

  Future<void> clearUserInfo() async {
    await _storage.delete(key: 'avatarUrl');
    await _storage.delete(key: 'username');
    _avatarUrl = '';
    _username = '';
    notifyListeners();
  }
}
