import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:voc/local_service/local_service.dart';
import 'package:voc/util.dart';

import '../../../api_service/body/send_message_body.dart';
import '../../../api_service/chat_service.dart';
import '../../../api_service/model/message.dart';
import '../../../api_service/model/sender.dart';
import '../../../api_service/response/send_message_response.dart';
import '../../../api_service/response/update_message_response.dart';
import '../../../local_service/message.dart';
import '../../../preferences.dart';
import '../model/chat_model.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ChatController extends GetxController {
  final model = ChatModel();
  final typeController = TextEditingController();
  final autoScrollController = AutoScrollController(axis: Axis.vertical);
  late ChatService chatService;
  late StreamSubscription<InternetConnectionStatus> listener;

  void allMessage() {
    LocalService.getAllMessageById(Get.arguments['chat_id'])?.listen((e) {
      model.messages.value = e;
      model.messages.refresh();
      scrollDown();
    });
  }

  Future<void> scrollToItem(int index) async {
    await autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
    await autoScrollController.highlight(index);
  }

  void scrollDown() {
    Future.delayed(const Duration(milliseconds: 500), () {
      autoScrollController.animateTo(
        autoScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
      );
    });

  }


  void updateSize() {
    if (model.size.value == 0) {
      model.size.value = 150.0;
    } else {
      model.size.value = 0.0;
    }
    model.size.refresh();
  }

  void showOriginalText() {
    model.showOriginalText.value = !model.showOriginalText.value;
    model.showOriginalText.refresh();
  }

  void showSendBtn(bool show) {
    model.showBtn.value = show;
    model.showBtn.refresh();
  }

  Future<void> checkRead() async {
    final messages = await LocalService.getAllMessageDelivById(Get.arguments['chat_id']);
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
          status: 'READ',
          time: e.time,
          date: e.date, createdAt: e.createdAt, replyMsgSenderId: e.replyMsgSenderId, replyTranslationMsg: e.replyTranslationMsg));
    });

    final data = jsonEncode(updateMsg);
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
      }
    } else {
      List<ChatMessage> updateMsg = [];
      messages?.forEach((e) {
        updateMsg.add(ChatMessage(id: e.id,
          chatId: e.chatId,
          senderId: e.senderId,
          message: e.message,
          translationMsg: e.translationMsg,
          attachmentType: e.attachmentType,
          replyMessageId: e.replyMessageId,
          replyMessage: e.replyMessage,
          time: e.time,
          date: e.date, statusMessage: 'READ', status: 'UNDONE', createdAt: e.createdAt, replyMsgSenderId: e.replyMsgSenderId, replyTranslationMsg: e.replyTranslationMsg,));
      });
      await LocalService.addAllMessage(updateMsg);
    }
  }

  Future<void> sendMessage() async {
    String id = Util.generateChar(10);
    String message = typeController.text;
    Map<String, dynamic> currentDate = Util.currentDateTime();
    typeController.clear();
    await LocalService.addMessage(ChatMessage(
        id: id,
        chatId: Get.arguments['chat_id'],
        senderId: Preferences.getUser()['id'],
        message: message,
        translationMsg: '',
        attachmentType: '',
        date: currentDate['date'],
        time: currentDate['time'],
        statusMessage: 'PENDING',
        replyMessageId: model.replyMessageId.value,
        replyMessage: model.replyMessage.value,
        status: 'UNDONE', createdAt: currentDate['time_stamp'], replyMsgSenderId: model.replyMsgSenderId.value, replyTranslationMsg: model.replyTranslationMsg.value));

    final body = SendMessageBody(Get.arguments['user_id'], message,
        id, Get.arguments['chat_id'], model.replyMessageId.value);
    showReply('', '', '', '');
    final response = await chatService.sendMessage(body);
    if (response.runtimeType == SendMessageResponse) {
      final send = response as SendMessageResponse;
      if (!send.error) {
        await LocalService.addMessage(ChatMessage(
            id: send.data.id,
            chatId: send.data.chatId,
            senderId: response.data.sender.id,
            message: send.data.message,
            translationMsg: send.data.translationMsg,
            attachmentType: '',
            date: response.data.date,
            time: response.data.time,
            statusMessage: response.data.status,
            replyMessageId: response.data.replyMessageId,
            replyMessage: response.data.replyMessage,
            status: 'DONE', createdAt: response.data.createdAt, replyMsgSenderId: response.data.replyMsgSenderId, replyTranslationMsg: response.data.replyTranslationMsg));
      } else {
        Fluttertoast.showToast(msg: send.message);
      }
    } else {
      Fluttertoast.showToast(msg: response.toString());
    }


  }

  void showReply(String message, String id, String senderId, String translationMsg) {
    model.replyMessage.value = message;
    model.replyMessageId.value = id;
    model.replyMsgSenderId.value = senderId;
    model.replyTranslationMsg.value = translationMsg;
    model.replyMessage.refresh();
  }

  @override
  void onReady() async {
    await LocalService.init();
    allMessage();

    autoScrollController.addListener(() {
      model.showScrollBottom.value = autoScrollController.position.pixels <
          autoScrollController.position.maxScrollExtent;
      model.showScrollBottom.refresh();
    });

    KeyboardVisibilityController().onChange.listen((e) {
      scrollDown();
    });

    checkRead();
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
