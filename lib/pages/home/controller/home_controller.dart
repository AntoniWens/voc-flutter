
import 'package:get/get.dart';
import 'package:voc/preferences.dart';

import '../../../api_service/chat_service.dart';
import '../../../api_service/model/chat.dart';
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
              lastMessage: Preferences.getUser()['id'] == msg[msg.length - 1].senderId ? msg[msg.length - 1].message : msg[msg.length - 1].translationMsg,
              translationMsg: msg[msg.length - 1].translationMsg,
              attachmentType: msg[msg.length - 1].attachmentType,
              messageStatus: msg[msg.length - 1].statusMessage,
              date: msg[msg.length - 1].date,
              time: msg[msg.length - 1].time, senderId: msg[msg.length - 1].senderId));
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
              lastMessage: Preferences.getUser()['id'] == msg[msg.length - 1].senderId ? msg[msg.length - 1].message : msg[msg.length - 1].translationMsg,
              translationMsg: msg[msg.length - 1].translationMsg,
              attachmentType: msg[msg.length - 1].attachmentType,
              messageStatus: msg[msg.length - 1].statusMessage,
              date: msg[msg.length - 1].date,
              time: msg[msg.length - 1].time, senderId: msg[msg.length - 1].senderId));
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
