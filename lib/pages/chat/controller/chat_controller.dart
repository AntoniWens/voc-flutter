
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:voc/local_service/local_service.dart';
import 'package:voc/util.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../api_service/body/send_message_body.dart';
import '../../../api_service/chat_service.dart';
import '../../../api_service/response/send_message_response.dart';
import '../../../api_service/response/user_chat_response.dart';
import '../../../api_service/response/websocket_response.dart';
import '../../../configuration.dart';
import '../../../local_service/all_chat.dart';
import '../../../local_service/message.dart';
import '../../../preferences.dart';
import '../model/chat_model.dart';

class ChatController extends GetxController {

  final model = ChatModel();
  final typeController = TextEditingController();
  final scrollController = ScrollController();
  late ChatService chatService;

  void allMessage() {
    LocalService.getAllMessage(Get.arguments['chat_id'])?.listen((e) {
      model.messages.value = e;
      model.messages.refresh();
    });
  }

  void createSocket() {
    final channel =
    WebSocketChannel.connect(Uri.parse(Configuration.socketUrl));

    channel.sink.add(jsonEncode({
      "event": "pusher:subscribe",
      "data": {"auth": "", "channel": "chat.voc.${Preferences.getUser()['id']}"}
    }));

    channel.stream.listen((e) async {
      final response = WebsocketResponse.fromJson(e);
      if (response.event == 'pusher:ping') {
        channel.sink.add(jsonEncode(
          {"event": "pusher:pong"},
        ));
      }

      if (response.data != null) {
        await LocalService.addChat(AllChat(
            response.data!.id,
            response.data!.users[0].id,
            response.data!.users[0].fullName,
            response.data!.users[0].language,
            response.data!.users[1].id,
            response.data!.users[1].fullName,
            response.data!.users[1].language,
            response.data!.message!.message,
            response.data!.message!.translationMsg,
            response.data!.message!.senderId,
            response.data!.message!.attachment,
            response.data!.message!.attachmentType,
            response.data!.message!.status,
            response.data!.date,
            response.data!.time));
        await LocalService.addMessage(ChatMessage(
            response.data!.message!.id,
            response.data!.message!.chatId,
            response.data!.message!.senderId,
            response.data!.message!.message,
            response.data!.message!.translationMsg,
            response.data!.message!.attachment,
            response.data!.message!.attachmentType,
            response.data!.date,
            response.data!.time, response.data!.message!.status,model.replyMessageId.value));
      }
    });
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void updateSize() {
    if (model.size.value == 0) {
      model.size.value = 150.0;
    } else {
      model.size.value = 0.0;
    }
    model.size.refresh();
  }

  void showOriginalText(bool original) {
    model.showOriginalText.value = original;
    model.showOriginalText.refresh();
  }

  void showSendBtn(bool show) {
    model.showBtn.value = show;
    model.showBtn.refresh();
  }

  Future<void> sendMessage() async {
    String id = Util.generateChar(10);
    await LocalService.addChat(AllChat(Get.arguments['chat_id'], Preferences.getUser()['id'],
        Preferences.getUser()['full_name'],
        Preferences.getUser()['language'],
        Get.arguments['user_id'], Get.arguments['full_name'], Get.arguments['language'], typeController.text, '',Preferences.getUser()['id'] , '', '','PENDING', Util.currentDateTime(true),
        Util.currentDateTime(false)));
    await LocalService.addMessage(ChatMessage(
        id,
        Get.arguments['chat_id'],
        Preferences.getUser()['id'],
        typeController.text,
        '',
        '',
        '',
        Util.currentDateTime(true),
        Util.currentDateTime(false),'PENDING',model.replyMessageId.value));
    final body = SendMessageBody(Get.arguments['user_id'], typeController.text, id, Get.arguments['chat_id'],model.replyMessageId.value);
    final response = await chatService.sendMessage(body);
    if (response.runtimeType == SendMessageResponse) {
      final send = response as SendMessageResponse;
      if (!send.error) {
        await LocalService.addChat(AllChat(
            response.data.id,
            response.data.users[0].id,
            response.data.users[0].fullName,
            response.data.users[0].language,
            response.data.users[1].id,
            response.data.users[1].fullName,
            response.data.users[1].language,
            response.data.message.message,
            response.data.message.translationMsg,
            response.data.message.senderId,
            response.data.message.attachment,
            response.data.message.attachmentType,
            response.data.message.status,
            response.data.date,
            response.data.time));
        await LocalService.addMessage(ChatMessage(
            send.data.message.id,
            send.data.id,
            response.data.message.senderId,
            send.data.message.message,
            send.data.message.translationMsg,
            '',
            '',
            response.data.date,
            response.data.time,
            response.data.message.status,model.replyMessageId.value));
        typeController.clear();
      } else {
        Fluttertoast.showToast(msg: send.message);
      }
    } else {
      Fluttertoast.showToast(msg: response.toString());
    }
  }

  void showReply(String message, String id) {
    model.replyMessage.value = message;
    model.replyMessageId.value = id;
    model.replyMessage.refresh();
  }

  @override
  void onReady() async {
    await LocalService.init();
    //createSocket();
    allMessage();
    super.onReady();
  }

  @override
  void onInit() {
    chatService = ChatService(token: Preferences.getToken());
    Preferences.saveInChat(true);
    super.onInit();
  }
  @override
  void onClose() {
    Preferences.saveInChat(false);
    super.onClose();
  }
}