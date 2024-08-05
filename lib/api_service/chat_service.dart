import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:voc/api_service/response/all_chats_response.dart';
import 'package:voc/api_service/response/send_message_response.dart';
import 'package:voc/api_service/response/user_chat_response.dart';

import '../configuration.dart';
import 'body/send_message_body.dart';

class ChatService {

  String token;
  ChatService({required this.token});

  Future<Object> allChats() async {
    try {
      final response =  await http.get(Uri.parse('${Configuration.baseUrl}api/mobile_api/chat/all-chats'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (kDebugMode) {
        print('response all chats : ${response.body}');
      }
      return AllChatsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }

  Future<Object> userChats() async {
    try {
      final response =  await http.get(Uri.parse('${Configuration.baseUrl}api/mobile_api/chat/messages'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (kDebugMode) {
        print('response user chats : ${response.body}');
      }
      return UserChatResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }

  Future<Object> updateMessages(String data) async {
    try {
      final response =  await http.post(Uri.parse('${Configuration.baseUrl}api/mobile_api/chat/update-message'),body: {'data':data}, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (kDebugMode) {
        print('response update_message : ${response.body}');
      }
      return SendMessageResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }

  Future<Object> sendMessage(SendMessageBody body) async {
    try {
      final response =  await http.post(Uri.parse('${Configuration.baseUrl}api/mobile_api/chat/send-message'),body: body.toJson(), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (kDebugMode) {
        print('response send_message : ${response.body}');
      }
      return SendMessageResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }
}