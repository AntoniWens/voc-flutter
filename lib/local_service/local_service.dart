
import 'package:voc/local_service/message.dart';

import '../main_database.dart';
import 'all_chat.dart';

class LocalService {

  static MainDatabase? _database;

  static Future<void> init() async {
   _database = await $FloorMainDatabase.databaseBuilder('chats')
       .build();
  }

  static Future<void> close() async {
   await _database?.close();
  }

  //sliders
  static Future<void> addAllChats(List<AllChat> allChats) async {
    await _database?.allChatDao.addChats(allChats);
  }

  static Future<void> addChat(AllChat allChat) async {
    await _database?.allChatDao.addChat(allChat);
  }

  static Stream<List<AllChat>>? getAllChats() {
    return _database?.allChatDao.getAllChats();
  }

  static Future<List<AllChat>>? allChats() {
    return _database?.allChatDao.queryAllChats();
  }

  static Future<AllChat?>? getChat(String receiverId, String senderId) {
    return _database?.allChatDao.getChat(receiverId, senderId);
  }

  static Future<void> deleteChat(String id) async {
    await _database?.allChatDao.deleteAllChat(id);
  }

  static Future<void> updateChat(String id, String status) async {
    await _database?.allChatDao.updateChat(id, status);
  }

  static Future<void> deleteChats() async {
    await _database?.allChatDao.deleteAllChats();
  }

  static Future<void> clearDatabase() async {
    await deleteChats();
  }

  static Future<void> addAllMessage(List<ChatMessage> message) async {
    await _database?.messageDao.addMessages(message);
  }

  static Future<void> addMessage(ChatMessage message) async {
    await _database?.messageDao.addMessage(message);
  }

  static Stream<List<ChatMessage>>? getAllMessageById(String chatId) {
    return _database?.messageDao.getAllMessageById(chatId);
  }

  static Future<List<ChatMessage>>? getAllMessageDelivById(String chatId) {
    return _database?.messageDao.getAllMessageDelivById(chatId);
  }

  static Future<ChatMessage?>? getLastMessage(String chatId) {
    return _database?.messageDao.getLastMessage(chatId);
  }

  static Future<List<ChatMessage>>? getAllMessage() {
    return _database?.messageDao.getAllMessage();
  }

  static Future<void> deleteMessage(String id) async {
    await _database?.messageDao.deleteMessage(id);
  }

  static Future<void> deleteAllMessage() async {
    await _database?.messageDao.deleteAllMessage();
  }

}