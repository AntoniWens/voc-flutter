
import 'package:floor/floor.dart';

import 'all_chat.dart';

@dao
abstract class AllChatDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addChats(List<AllChat> allChats);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addChat(AllChat allChat);

  @Query('SELECT * FROM AllChat')
  Stream<List<AllChat>> getAllChats();

  @Query('SELECT * FROM AllChat')
  Future<List<AllChat>> queryAllChats();

  @Query('SELECT * FROM AllChat WHERE (userOneId = :senderId AND userTwoId = :receiverId) OR (userOneId = :receiverId AND userTwoId = :senderId)')
  Future<AllChat?> getChat(String receiverId, String senderId);

  @Query('DELETE FROM AllChat WHERE id = :id')
  Future<void> deleteAllChat(String id);

  @Query('UPDATE AllChat SET trigger = :triggers WHERE id = :id')
  Future<void> updateChat(String id, String triggers);

  @Query('DELETE FROM AllChat')
  Future<void> deleteAllChats();
}