import 'package:get/get.dart';
import 'package:voc/api_service/chat_service.dart';
import 'package:voc/local_service/message.dart';
import 'package:voc/preferences.dart';
import 'package:voc/route_management/routes.dart';

import '../../../api_service/response/all_chats_response.dart';
import '../../../api_service/response/user_chat_response.dart';
import '../../../local_service/all_chat.dart';
import '../../../local_service/local_service.dart';

class SyncingController extends GetxController {

  late ChatService chatService;

  Future<void> allChatsAPI() async {
    print(Preferences.getToken());
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
        if(allChats.isNotEmpty) {
          await LocalService.addAllChats(allChats);
        }
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
            e.status,));
        }
        if (chatMessage.isNotEmpty) {
          await LocalService.addAllMessage(chatMessage);
        }
        Get.offAllNamed(Routes.home, arguments: 'da');
      }
    }
  }
  @override
  void onReady() async {
    await LocalService.init();
    await allChatsAPI();
    await userChats();
    super.onReady();
  }

  @override
  void onInit() {
    chatService = ChatService(token: Preferences.getToken());
    super.onInit();
  }
}