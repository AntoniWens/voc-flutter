import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:voc/api_service/response/all_users_response.dart';

import '../configuration.dart';
class UserService {

  final String _token;
  UserService(this._token);

  Future<Object> allUsers() async {
    try {
      final response =  await http.get(Uri.parse('${Configuration.baseUrl}api/mobile_api/user/users'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token'
      });
      if (kDebugMode) {
        print('response all users : ${response.body}');
      }
      return AllUsersResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }
}