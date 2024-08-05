import 'dart:convert';

import 'package:get/get.dart';
import 'package:voc/api_service/model/Message.dart';
import 'package:voc/api_service/model/update_message.dart';
import 'package:voc/api_service/response/update_message_response.dart';
import 'package:voc/api_service/response/websocket_response.dart';
import 'package:voc/configuration.dart';
import 'package:voc/local_service/message.dart';
import 'package:voc/preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../api_service/chat_service.dart';
import '../../../api_service/model/chat.dart';
import '../../../api_service/response/all_chats_response.dart';
import '../../../local_service/all_chat.dart';
import '../../../local_service/local_service.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  final model = HomeModel();
  late ChatService chatService;

  void listenAllChats() {
    LocalService.getAllChats()?.listen((e) async {
      List<Chat> chats = [];
      for (var a in e) {
        final msg = await LocalService.getLastMessage(a.id);
        if (msg != null) {
          chats.add(Chat(
              id: a.id,
              userOneId: a.userOneId,
              userOneFullname: a.userOneFullname,
              userOneLanguage: a.userOneLanguage,
              userTwoId: a.userTwoId,
              userTwoFullname: a.userTwoFullname,
              userTwoLanguage: a.userTwoLanguage,
              lastMessage: msg.message,
              translationMsg: msg.translationMsg,
              attachment: msg.attachment,
              attachmentType: msg.attachmentType,
              messageStatus: msg.status,
              date: msg.date,
              time: msg.time));
        }
        model.allChats.value = chats;
        model.allChats.refresh();
      }
    });
  }

  void queryAllChat() {
    LocalService.allChats()?.then((e) async {
      List<Chat> chats = [];
      for (var a in e) {
        final msg = await LocalService.getLastMessage(a.id);
        if (msg != null) {
          chats.add(Chat(
              id: a.id,
              userOneId: a.userOneId,
              userOneFullname: a.userOneFullname,
              userOneLanguage: a.userOneLanguage,
              userTwoId: a.userTwoId,
              userTwoFullname: a.userTwoFullname,
              userTwoLanguage: a.userTwoLanguage,
              lastMessage: msg.message,
              translationMsg: msg.translationMsg,
              attachment: msg.attachment,
              attachmentType: msg.attachmentType,
              messageStatus: msg.statusMessage,
              date: msg.date,
              time: msg.time));
        }
      }
      model.allChats.value = chats;
      model.allChats.refresh();
    });
  }



  @override
  void onReady() {
    listenAllChats();

    super.onReady();
  }

  @override
  void onInit() async {
    await LocalService.init();
    Preferences.saveInChat(false);
    chatService = ChatService(token: Preferences.getToken());
    super.onInit();
  }
}
