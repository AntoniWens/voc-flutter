import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:voc/local_service/local_service.dart';
import 'package:voc/util.dart';

import '../../../api_service/body/send_message_body.dart';
import '../../../api_service/chat_service.dart';
import '../../../api_service/response/send_message_response.dart';
import '../../../local_service/all_chat.dart';
import '../../../local_service/message.dart';
import '../../../preferences.dart';
import '../model/chat_model.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ChatController extends GetxController {
  final model = ChatModel();
  final typeController = TextEditingController();
  final autoScrollController = AutoScrollController(axis: Axis.vertical);
  late ChatService chatService;

  FocusNode focusNode = FocusNode();

  void allMessage() {
    LocalService.getAllMessageById(Get.arguments['chat_id'])?.listen((e) {
      model.messages.value = e;
      Future.delayed(Duration(milliseconds: 500), () {
        scrollDown();
      });
      model.messages.refresh();
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
    autoScrollController.animateTo(
      autoScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
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
    await LocalService.addMessage(ChatMessage(
        id: id,
        chatId: Get.arguments['chat_id'],
        senderId: Preferences.getUser()['id'],
        message: typeController.text,
        translationMsg: '',
        attachment: '',
        attachmentType: '',
        date: Util.currentDateTime(true),
        time: Util.currentDateTime(false),
        statusMessage: 'PENDING',
        replyMessageId: model.replyMessageId.value,
        replyMessage: model.replyMessage.value,
        status: 'UNDONE'));
    final body = SendMessageBody(Get.arguments['user_id'], typeController.text,
        id, Get.arguments['chat_id'], model.replyMessageId.value);
    final response = await chatService.sendMessage(body);
    if (response.runtimeType == SendMessageResponse) {
      final send = response as SendMessageResponse;
      if (!send.error) {
        await LocalService.addMessage(ChatMessage(
            id: send.data.message.id,
            chatId: send.data.id,
            senderId: response.data.message.senderId,
            message: send.data.message.message,
            translationMsg: send.data.message.translationMsg,
            attachment: '',
            attachmentType: '',
            date: response.data.date,
            time: response.data.time,
            statusMessage: response.data.message.status,
            replyMessageId: model.replyMessageId.value,
            replyMessage: model.replyMessage.value,
            status: 'DONE'));
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
    allMessage();

    autoScrollController.addListener(() {
      model.showScrollBottom.value = autoScrollController.position.pixels <
          autoScrollController.position.maxScrollExtent;
      model.showScrollBottom.refresh();
    });

    KeyboardVisibilityController().onChange.listen((e) {
      Future.delayed(Duration(milliseconds: 500), () => {scrollDown()});
    });

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
    focusNode.dispose();
    super.onClose();
  }
}
