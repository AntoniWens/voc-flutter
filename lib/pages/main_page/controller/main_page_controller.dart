
import 'dart:convert';

import 'package:get/get.dart';
import 'package:voc/api_service/chat_service.dart';
import 'package:voc/api_service/model/sender.dart';
import 'package:voc/fcm_service.dart';
import 'package:voc/notification_service.dart';
import 'package:voc/pages/home/controller/home_controller.dart';
import 'package:voc/preferences.dart';
import 'package:voc/util.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../api_service/model/chat.dart';
import '../../../api_service/model/message.dart';
import '../../../api_service/response/all_chats_response.dart';
import '../../../api_service/response/update_message_response.dart';
import '../../../api_service/response/websocket_response.dart';
import '../../../configuration.dart';
import '../../../local_service/all_chat.dart';
import '../../../local_service/local_service.dart';
import '../../../local_service/message.dart';
import '../model/main_page_model.dart';

class MainPageController extends GetxController {
  final model = MainPageModel();
  late ChatService chatService;

  void onItemTapped(int index) {
    model.selectedIndex.value = index;
    model.selectedIndex.refresh();
  }

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
          status: e.statusMessage,
          time: e.time,
          date: e.date, createdAt: e.createdAt, replyMsgSenderId: e.replyMsgSenderId));
    });
    if (updateMsg.isNotEmpty) {
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
                status: 'DONE', createdAt: e.createdAt, replyMsgSenderId: e.replyMsgSenderId));
          }
          await LocalService.addAllMessage(messages);
        }
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
              userTwoLanguage: e.users[1].language, trigger: 'k'));
        }
        for (var e in allChatRes.data.messages) {
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
              status: 'DONE', createdAt: e.createdAt, replyMsgSenderId: e.replyMsgSenderId));
        }
        await LocalService.addAllMessage(messages);
        await LocalService.addAllChats(allChats);
      }
    }
  }

  void createSocket() {
    final channel =
    WebSocketChannel.connect(Uri.parse(Configuration.socketUrl));

    channel.sink.add(jsonEncode({
      "event": "pusher:subscribe",
      "data": {"auth": '', "channel": "chat.voc.${Preferences.getUser()['id']}"}
    }));

    channel.stream.listen((e) async {
      print(e);
      final res = jsonDecode(e);
      if (res['event'] == 'pusher:ping') {
        channel.sink.add(jsonEncode(
          {"event": "pusher:pong"},
        ));
      }
      if (res['data'] != null) {
        if (jsonDecode(res['data'])['result'] != null) {
          final response = WebsocketResponse.fromJson(jsonDecode(e));
          await LocalService.addMessage(ChatMessage(
              id: response.data!.id,
              chatId: response.data!.chatId,
              senderId: response.data!.sender.id,
              message: response.data!.message,
              translationMsg: response.data!.translationMsg,
              attachmentType: response.data!.attachmentType,
              date: response.data!.date,
              time: response.data!.time,
              statusMessage: response.data!.status,
              replyMessageId: response.data!.replyMessageId,
              replyMessage: response.data!.replyMessage,
              status: 'DONE', createdAt: response.data!.createdAt, replyMsgSenderId: response.data!.replyMsgSenderId));

          if (Preferences.getInChat()) {
            List<Message> updateMsg = [];
            updateMsg.add(Message(id: response.data!.id,
                chatId: response.data!.chatId,
                sender: response.data!.sender,
                message: response.data!.message,
                translationMsg: response.data!.translationMsg,
                attachmentType: response.data!.attachmentType,
                replyMessageId: response.data!.replyMessageId,
                replyMessage: response.data!.replyMessage,
                status: 'READING',
                time: response.data!.time,
                date: response.data!.date, createdAt: response.data!.createdAt, replyMsgSenderId: response.data!.replyMsgSenderId));
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
                      status: 'DONE', createdAt: e.createdAt, replyMsgSenderId: e.replyMsgSenderId));
                }
                await LocalService.addAllMessage(messages);
              }
            }
          }
          Get.find<HomeController>().queryAllChat();
          //await LocalService.updateChat(response.data!.chatId, Util.generateChar(4));
        }
      }
    });
  }

  @override
  void onReady() async {
    createSocket();
    FcmService.onMessage().listen((e) {
      NotificationService.cancelNotifications();
    });
    NotificationService.checkNotificationPermission();
    if (Get.arguments == null) {
      await syncData();
    }
    super.onReady();
  }

  @override
  void onInit() async {
    await LocalService.init();
    chatService = ChatService(token: Preferences.getToken());
    createSocket();
    super.onInit();
  }
}