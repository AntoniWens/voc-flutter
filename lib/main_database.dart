import 'dart:async';


import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:voc/local_service/message.dart';
import 'package:voc/local_service/message_dao.dart';

import 'local_service/all_chat.dart';
import 'local_service/all_chat_dao.dart';
part 'main_database.g.dart';

@Database(version: 1, entities: [AllChat, ChatMessage])
abstract class MainDatabase extends FloorDatabase {
  AllChatDao get allChatDao;
  MessageDao get messageDao;
}