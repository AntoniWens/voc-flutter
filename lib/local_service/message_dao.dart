
import 'package:floor/floor.dart';
import 'package:voc/api_service/response/all_chats_response.dart';

import 'all_chat.dart';
import 'message.dart';

@dao
abstract class MessageDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addMessages(List<ChatMessage> messages);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addMessage(ChatMessage message);

  @Query('SELECT * FROM ChatMessage WHERE chatId =:chatId ORDER BY date,time ASC')
  Stream<List<ChatMessage>> getAllMessage(String chatId);

  @Query('DELETE FROM ChatMessage WHERE id =:id')
  Future<void> deleteMessage(String id);

  @Query('UPDATE FROM ChatMessage WHERE id =:id')
  Future<void> updateMessage(String id);

  @Query('DELETE FROM ChatMessage')
  Future<void> deleteAllMessage();
}