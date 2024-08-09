import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:voc/api_service/response/default_response.dart';
import 'package:voc/api_service/response/login_response.dart';

import '../configuration.dart';
import 'body/register_body.dart';
import 'body/send_otp_body.dart';

class Auth {

  Future<Object> login(String countryCode, String phone, String password, String token) async {
    try {
      final response =  await http.post(Uri.parse('${Configuration.baseUrl}api/mobile_api/auth/login'), body: {
        'country_code': '+$countryCode',
        'phone_number': phone,
        'password': password,
        'token': token
      }, headers: {
        'Accept': 'application/json'
      });
      print(response.body);
      return LoginResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }

  }

  Future<Object> sendOtp(SendOtpBody body) async {
    try {
      final response =  await http.post(Uri.parse('${Configuration.baseUrl}api/mobile_api/auth/send-otp'), body: body.toJson() , headers: {
      'Accept': 'application/json'
      });
      if (kDebugMode) {
        print('response send otp : ${response.body}');
      }
      return DefaultResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }

  }

  Future<Object> register(RegisterBody body) async {
    try {
      final response =  await http.post(Uri.parse('${Configuration.baseUrl}api/mobile_api/auth/register'), body: body.toJson(), headers: {
      'Accept': 'application/json'
      });
      if (kDebugMode) {
        print('response register : ${response.body}');
      }
      return LoginResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }

  }
  Future<Object> logout(String token) async {
    try {
      final response =  await http.post(Uri.parse('${Configuration.baseUrl}api/mobile_api/auth/logout'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (kDebugMode) {
        print('response logout : ${response.body}');
      }
      return 'Success';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }

  }
}
