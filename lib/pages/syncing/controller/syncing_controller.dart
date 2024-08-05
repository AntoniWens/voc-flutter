import 'dart:convert';

import 'package:get/get.dart';
import 'package:voc/api_service/chat_service.dart';
import 'package:voc/local_service/message.dart';
import 'package:voc/preferences.dart';
import 'package:voc/route_management/routes.dart';

import '../../../api_service/model/Message.dart';
import '../../../api_service/response/all_chats_response.dart';
import '../../../api_service/response/update_message_response.dart';
import '../../../api_service/response/user_chat_response.dart';
import '../../../local_service/all_chat.dart';
import '../../../local_service/local_service.dart';

class SyncingController extends GetxController {

  late ChatService chatService;

  Future<void> syncData() async {
    final messages = await LocalService.getAllMessage();
    List<Message> updateMsg = [];
    messages?.forEach((e) {
      updateMsg.add(Message(id: e.id,
          chatId: e.chatId,
          senderId: e.senderId,
          message: e.message,
          translationMsg: e.translationMsg,
          attachment: e.attachment,
          attachmentType: e.attachmentType,
          replyMessageId: e.replyMessageId,
          replyMessage: e.replyMessage,
          status: e.status,
          time: e.time,
          date: e.date));
    });
    final data = jsonEncode(updateMsg.map((e) => e.toJson()));
    final response1 = await chatService.updateMessages(data);
    if (response1.runtimeType == UpdateMessageResponse) {
      final updateRes = response1 as UpdateMessageResponse;
      if (!updateRes.error) {
        List<ChatMessage> messages = [];
        for (var e in updateRes.data) {
          messages.add(ChatMessage(
              id: e.id,
              chatId: e.chatId,
              senderId: e.senderId,
              message: e.message,
              translationMsg: e.translationMsg,
              attachment: e.attachment,
              attachmentType: e.attachmentType,
              date: e.date,
              time: e.time,
              status: e.status,
              replyMessageId: e.replyMessageId,
              replyMessage: e.replyMessage,
              statusMessage: 'DONE'));
        }
        await LocalService.addAllMessage(messages);
      }
    }

    final response = await chatService.allChats();
    if (response.runtimeType == AllChatsResponse) {
      final allChatRes = response as AllChatsResponse;
      if (!allChatRes.error) {
        List<AllChat> allChats = [];
        List<ChatMessage> messages = [];
        for (var e in allChatRes.data.chats) {
          allChats.add(AllChat(
              id: e.id,
              userOneId: e.users[0].id,
              userOneFullname: e.users[0].fullName,
              userOneLanguage: e.users[0].language,
              userTwoId: e.users[1].id,
              userTwoFullname: e.users[1].fullName,
              userTwoLanguage: e.users[1].language));
        }
        for (var e in allChatRes.data.messages) {
          messages.add(ChatMessage(
              id: e.id,
              chatId: e.chatId,
              senderId: e.senderId,
              message: e.message,
              translationMsg: e.translationMsg,
              attachment: e.attachment,
              attachmentType: e.attachmentType,
              date: e.date,
              time: e.time,
              status: e.status,
              replyMessageId: e.replyMessageId,
              replyMessage: e.replyMessage,
              statusMessage: 'DONE'));
        }
        await LocalService.addAllMessage(messages);
        await LocalService.addAllChats(allChats);
      }
    }
  }

  @override
  void onReady() async {
    await LocalService.init();
    await syncData();
    super.onReady();
  }

  @override
  void onInit() {
    chatService = ChatService(token: Preferences.getToken());
    super.onInit();
  }
}