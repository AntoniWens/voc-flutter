
import 'package:floor/floor.dart';

import 'message.dart';

@dao
abstract class MessageDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addMessages(List<ChatMessage> messages);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addMessage(ChatMessage message);

  @Query("SELECT * FROM ChatMessage WHERE status = 'UNDONE'")
  Future<List<ChatMessage>> getAllMessage();

  @Query("SELECT * FROM ChatMessage WHERE statusMessage = 'DELIVERED' AND chatId =:chatId")
  Future<List<ChatMessage>> getAllMessageDelivById(String chatId);

  @Query('SELECT * FROM ChatMessage WHERE chatId =:chatId ORDER BY createdAt ASC')
  Stream<List<ChatMessage>> getAllMessageById(String chatId);

  @Query('SELECT * FROM ChatMessage WHERE chatId =:chatId ORDER BY createdAt ASC')
  Future<List<ChatMessage>?> getLastMessage(String chatId);

  @Query('DELETE FROM ChatMessage WHERE id =:id')
  Future<void> deleteMessage(String id);

  @Query('UPDATE FROM ChatMessage WHERE id =:id')
  Future<void> updateMessage(String id);

  @Query('DELETE FROM ChatMessage')
  Future<void> deleteAllMessage();
}