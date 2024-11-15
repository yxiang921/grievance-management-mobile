import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  Future<void> setUserInfo(String userID, String email, String avatar, String username) async {
    await _storage.write(key: 'userID', value: userID);
    await _storage.write(key: 'email', value: _email);
    await _storage.write(key: 'avatar', value: avatar);
    await _storage.write(key: 'username', value: username);
    notifyListeners();
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
