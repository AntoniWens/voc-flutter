import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service/response/login_response.dart';

class Preferences {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _preferences?.setString(_tokenKey, token);
  }

  static Future<void> saveUser(UserData data) async {
    await _preferences?.setString(_userKey, jsonEncode(data.toJson()));
  }

  static Future<void> saveInChat(bool inChat) async {
    await _preferences?.setBool(_inChat, inChat);
  }

  static bool getInChat() {
    return _preferences?.getBool(_inChat) ?? false;
  }

  static String getToken() {
    return _preferences?.getString(_tokenKey) ?? '';
  }

  static Map<String, dynamic> getUser() {
    return jsonDecode(_preferences?.getString(_userKey) ?? '');
  }

  static clear() {
    _preferences?.clear();
  }

  static const _tokenKey = 'token';
  static const _userKey = 'user';
  static const _inChat = 'in_chat';
}