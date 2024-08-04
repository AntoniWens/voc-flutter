import 'dart:convert';

import 'package:get/get.dart';
import 'package:voc/api_service/response/websocket_response.dart';
import 'package:voc/configuration.dart';
import 'package:voc/local_service/message.dart';
import 'package:voc/preferences.dart';
import 'package:web_socket_channel/io.dart';

import '../../../api_service/chat_service.dart';
import '../../../api_service/response/all_chats_response.dart';
import '../../../api_service/response/user_chat_response.dart';
import '../../../local_service/all_chat.dart';
import '../../../local_service/local_service.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  final model = HomeModel();
  late ChatService chatService;

  Future<void> allChatsAPI() async {
    final response = await chatService.allChats();
    if (response.runtimeType == AllChatsResponse) {
      final allChatRes = response as AllChatsResponse;
      if (!allChatRes.error) {
        List<AllChat> allChats = [];
        for (var e in allChatRes.data) {
          allChats.add(AllChat(
              e.id,
              e.users[0].id,
              e.users[0].fullName,
              e.users[0].language,
              e.users[1].id,
              e.users[1].fullName,
              e.users[1].language,
              e.message.message,
              e.message.translationMsg,
              e.message.senderId,
              e.message.attachment,
              e.message.attachmentType,
              e.message.status,
              e.date,
              e.time));
        }
        await LocalService.addAllChats(allChats);
      }
    }
  }

  Future<void> userChats() async {
    final response = await chatService.userChats();
    if (response.runtimeType == UserChatResponse) {
      final allRes = response as UserChatResponse;
      if (!allRes.error) {
        List<ChatMessage> chatMessage = [];
        for (var e in allRes.data) {
          chatMessage.add(ChatMessage(
            e.id,
            e.chatId,
            e.senderId,
            e.message,
            e.translationMsg,
            e.attachment,
            e.attachmentType,
            e.date,
            e.time,
            e.status,e.replyMessageId, e.replyMessage));
        }
        if (chatMessage.isNotEmpty) {
          await LocalService.addAllMessage(chatMessage);
        }
      }
    }
  }

  void listenAllChats() {
    LocalService.getAllChats()?.listen((e) {

      model.allChats.value = e;
      model.allChats.refresh();
      print(model.allChats.length);
    });
  }

  void queryAllChat() {
    LocalService.allChats()?.then((e) {
      model.allChats.value = e;
      model.allChats.refresh();
    });
  }

  void createSocket() {
    final channel =
        IOWebSocketChannel.connect(Uri.parse(Configuration.socketUrl), headers: {
          "Authorization": "Bearer ${Preferences.getToken()}",
          "Accept": "application/json"
        });

    channel.sink.add(jsonEncode({
      "event": "pusher:subscribe",
      "data": {
        "auth":'',
        "channel": "chat.voc.${Preferences.getUser()['id']}"
      }
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
        print('ss${jsonDecode(e)}');
        if (jsonDecode(res['data'])['result'] != null) {
          final response = WebsocketResponse.fromJson(jsonDecode(e));
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
              Preferences.getInChat() ? 'SUCCESS' : 'DELIVERED',
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
            response.data!.time,
            response.data!.message!.status,
            response.data!.message!.replyMessageId, response.data!.message!.replyMessage
          ));
        }
      }
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
    print(Preferences.getUser()['id']);
    chatService = ChatService(token: Preferences.getToken());
    createSocket();
    if (Get.arguments == null) {
      await allChatsAPI();
      await userChats();
    }
    super.onInit();
  }
}
