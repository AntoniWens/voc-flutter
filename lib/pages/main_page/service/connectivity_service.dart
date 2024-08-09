import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:voc/api_service/chat_service.dart';
import 'package:voc/api_service/model/sender.dart';
import 'package:voc/local_service/local_service.dart';
import 'package:voc/pages/home/controller/home_controller.dart';
import 'package:voc/preferences.dart';

import '../../../api_service/model/message.dart';
import '../../../api_service/response/update_message_response.dart';
import '../../../local_service/message.dart';

class ConnectivityService extends GetxService {

  late StreamSubscription<InternetConnectionStatus> listener;
  late ChatService chatService;

  Future<void> syncData() async {
    final messages = await LocalService.getAllMessage();
    List<Message> updateMsg = [];
    messages?.forEach((e) {
      updateMsg.add(Message(id: e.id,
          chatId: e.chatId,
          sender: Sender(id: e.senderId, fullName: '', photoUrl: ''),
          message: e.message,
          translationMsg: e.translationMsg,
          attachmentType: e.attachmentType,
          replyMessageId: e.replyMessageId,
          replyMessage: e.replyMessage,
          status: e.status,
          time: e.time,
          date: e.date, createdAt: e.createdAt, replyMsgSenderId: e.replyMsgSenderId, replyTranslationMsg: e.replyTranslationMsg));
    });
    final data = jsonEncode(updateMsg);
    print(data);
    final response1 = await chatService.updateMessages(data);
    if (response1.runtimeType == UpdateMessageResponse) {
      final updateRes = response1 as UpdateMessageResponse;
      if (!updateRes.error) {
        List<ChatMessage> messages = [];
        for (var e in updateRes.data) {
          messages.add(ChatMessage(
              id: e.id,
              chatId: e.chatId,
              senderId: e.sender.id,
              message: e.message,
              translationMsg: e.translationMsg,
              attachmentType: e.attachmentType,
              date: e.date,
              time: e.time,
              statusMessage: e.status,
              replyMessageId: e.replyMessageId,
              replyMessage: e.replyMessage,
              status: 'DONE', createdAt: e.createdAt, replyMsgSenderId: e.replyMsgSenderId, replyTranslationMsg: e.replyTranslationMsg));
        }
        await LocalService.addAllMessage(messages);
        Get.find<HomeController>().queryAllChat();
      }
    }
  }

  @override
  void onReady() async{
    await LocalService.init();
    listener = InternetConnectionChecker().onStatusChange.listen((status) async {
      switch (status) {
        case InternetConnectionStatus.connected:
          await syncData();
          break;
        case InternetConnectionStatus.disconnected:
          break;
      }
    });
    super.onReady();
  }

  @override
  void onInit() {
    chatService = ChatService(token: Preferences.getToken());
    super.onInit();
  }

  @override
  void onClose() {
    listener.cancel();
    super.onClose();
  }
}