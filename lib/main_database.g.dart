// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $MainDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $MainDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $MainDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<MainDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorMainDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MainDatabaseBuilderContract databaseBuilder(String name) =>
      _$MainDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MainDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$MainDatabaseBuilder(null);
}

class _$MainDatabaseBuilder implements $MainDatabaseBuilderContract {
  _$MainDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $MainDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $MainDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<MainDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MainDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MainDatabase extends MainDatabase {
  _$MainDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AllChatDao? _allChatDaoInstance;

  MessageDao? _messageDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AllChat` (`id` TEXT NOT NULL, `userOneId` TEXT NOT NULL, `userOneFullname` TEXT NOT NULL, `userOneLanguage` TEXT NOT NULL, `userTwoId` TEXT NOT NULL, `userTwoFullname` TEXT NOT NULL, `userTwoLanguage` TEXT NOT NULL, `trigger` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChatMessage` (`id` TEXT NOT NULL, `chatId` TEXT NOT NULL, `senderId` TEXT NOT NULL, `message` TEXT NOT NULL, `translationMsg` TEXT NOT NULL, `attachmentType` TEXT NOT NULL, `date` TEXT NOT NULL, `time` TEXT NOT NULL, `statusMessage` TEXT NOT NULL, `replyMessageId` TEXT NOT NULL, `replyMessage` TEXT NOT NULL, `status` TEXT NOT NULL, `createdAt` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AllChatDao get allChatDao {
    return _allChatDaoInstance ??= _$AllChatDao(database, changeListener);
  }

  @override
  MessageDao get messageDao {
    return _messageDaoInstance ??= _$MessageDao(database, changeListener);
  }
}

class _$AllChatDao extends AllChatDao {
  _$AllChatDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _allChatInsertionAdapter = InsertionAdapter(
            database,
            'AllChat',
            (AllChat item) => <String, Object?>{
                  'id': item.id,
                  'userOneId': item.userOneId,
                  'userOneFullname': item.userOneFullname,
                  'userOneLanguage': item.userOneLanguage,
                  'userTwoId': item.userTwoId,
                  'userTwoFullname': item.userTwoFullname,
                  'userTwoLanguage': item.userTwoLanguage,
                  'trigger': item.trigger
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AllChat> _allChatInsertionAdapter;

  @override
  Stream<List<AllChat>> getAllChats() {
    return _queryAdapter.queryListStream('SELECT * FROM AllChat',
        mapper: (Map<String, Object?> row) => AllChat(
            id: row['id'] as String,
            userOneId: row['userOneId'] as String,
            userOneFullname: row['userOneFullname'] as String,
            userOneLanguage: row['userOneLanguage'] as String,
            userTwoId: row['userTwoId'] as String,
            userTwoFullname: row['userTwoFullname'] as String,
            userTwoLanguage: row['userTwoLanguage'] as String,
            trigger: row['trigger'] as String),
        queryableName: 'AllChat',
        isView: false);
  }

  @override
  Future<List<AllChat>> queryAllChats() async {
    return _queryAdapter.queryList('SELECT * FROM AllChat',
        mapper: (Map<String, Object?> row) => AllChat(
            id: row['id'] as String,
            userOneId: row['userOneId'] as String,
            userOneFullname: row['userOneFullname'] as String,
            userOneLanguage: row['userOneLanguage'] as String,
            userTwoId: row['userTwoId'] as String,
            userTwoFullname: row['userTwoFullname'] as String,
            userTwoLanguage: row['userTwoLanguage'] as String,
            trigger: row['trigger'] as String));
  }

  @override
  Future<AllChat?> getChat(
    String receiverId,
    String senderId,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM AllChat WHERE (userOneId = ?2 AND userTwoId = ?1) OR (userOneId = ?1 AND userTwoId = ?2)',
        mapper: (Map<String, Object?> row) => AllChat(id: row['id'] as String, userOneId: row['userOneId'] as String, userOneFullname: row['userOneFullname'] as String, userOneLanguage: row['userOneLanguage'] as String, userTwoId: row['userTwoId'] as String, userTwoFullname: row['userTwoFullname'] as String, userTwoLanguage: row['userTwoLanguage'] as String, trigger: row['trigger'] as String),
        arguments: [receiverId, senderId]);
  }

  @override
  Future<void> deleteAllChat(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM AllChat WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> updateChat(
    String id,
    String triggers,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE AllChat SET trigger = ?2 WHERE id = ?1',
        arguments: [id, triggers]);
  }

  @override
  Future<void> deleteAllChats() async {
    await _queryAdapter.queryNoReturn('DELETE FROM AllChat');
  }

  @override
  Future<void> addChats(List<AllChat> allChats) async {
    await _allChatInsertionAdapter.insertList(
        allChats, OnConflictStrategy.replace);
  }

  @override
  Future<void> addChat(AllChat allChat) async {
    await _allChatInsertionAdapter.insert(allChat, OnConflictStrategy.replace);
  }
}

class _$MessageDao extends MessageDao {
  _$MessageDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _chatMessageInsertionAdapter = InsertionAdapter(
            database,
            'ChatMessage',
            (ChatMessage item) => <String, Object?>{
                  'id': item.id,
                  'chatId': item.chatId,
                  'senderId': item.senderId,
                  'message': item.message,
                  'translationMsg': item.translationMsg,
                  'attachmentType': item.attachmentType,
                  'date': item.date,
                  'time': item.time,
                  'statusMessage': item.statusMessage,
                  'replyMessageId': item.replyMessageId,
                  'replyMessage': item.replyMessage,
                  'status': item.status,
                  'createdAt': item.createdAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ChatMessage> _chatMessageInsertionAdapter;

  @override
  Future<List<ChatMessage>> getAllMessage() async {
    return _queryAdapter.queryList(
        'SELECT * FROM ChatMessage WHERE status = \'UNDONE\'',
        mapper: (Map<String, Object?> row) => ChatMessage(
            id: row['id'] as String,
            chatId: row['chatId'] as String,
            senderId: row['senderId'] as String,
            message: row['message'] as String,
            translationMsg: row['translationMsg'] as String,
            attachmentType: row['attachmentType'] as String,
            date: row['date'] as String,
            time: row['time'] as String,
            statusMessage: row['statusMessage'] as String,
            replyMessageId: row['replyMessageId'] as String,
            replyMessage: row['replyMessage'] as String,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String));
  }

  @override
  Future<List<ChatMessage>> getAllMessageDelivById(String chatId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ChatMessage WHERE statusMessage = \'DELIVERED\' AND chatId =?1',
        mapper: (Map<String, Object?> row) => ChatMessage(id: row['id'] as String, chatId: row['chatId'] as String, senderId: row['senderId'] as String, message: row['message'] as String, translationMsg: row['translationMsg'] as String, attachmentType: row['attachmentType'] as String, date: row['date'] as String, time: row['time'] as String, statusMessage: row['statusMessage'] as String, replyMessageId: row['replyMessageId'] as String, replyMessage: row['replyMessage'] as String, status: row['status'] as String, createdAt: row['createdAt'] as String),
        arguments: [chatId]);
  }

  @override
  Stream<List<ChatMessage>> getAllMessageById(String chatId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM ChatMessage WHERE chatId =?1 ORDER BY createdAt ASC',
        mapper: (Map<String, Object?> row) => ChatMessage(
            id: row['id'] as String,
            chatId: row['chatId'] as String,
            senderId: row['senderId'] as String,
            message: row['message'] as String,
            translationMsg: row['translationMsg'] as String,
            attachmentType: row['attachmentType'] as String,
            date: row['date'] as String,
            time: row['time'] as String,
            statusMessage: row['statusMessage'] as String,
            replyMessageId: row['replyMessageId'] as String,
            replyMessage: row['replyMessage'] as String,
            status: row['status'] as String,
            createdAt: row['createdAt'] as String),
        arguments: [chatId],
        queryableName: 'ChatMessage',
        isView: false);
  }

  @override
  Future<ChatMessage?> getLastMessage(String chatId) async {
    return _queryAdapter.query(
        'SELECT * FROM ChatMessage WHERE chatId =?1 ORDER BY date,time DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => ChatMessage(id: row['id'] as String, chatId: row['chatId'] as String, senderId: row['senderId'] as String, message: row['message'] as String, translationMsg: row['translationMsg'] as String, attachmentType: row['attachmentType'] as String, date: row['date'] as String, time: row['time'] as String, statusMessage: row['statusMessage'] as String, replyMessageId: row['replyMessageId'] as String, replyMessage: row['replyMessage'] as String, status: row['status'] as String, createdAt: row['createdAt'] as String),
        arguments: [chatId]);
  }

  @override
  Future<void> deleteMessage(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM ChatMessage WHERE id =?1', arguments: [id]);
  }

  @override
  Future<void> updateMessage(String id) async {
    await _queryAdapter
        .queryNoReturn('UPDATE FROM ChatMessage WHERE id =?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllMessage() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ChatMessage');
  }

  @override
  Future<void> addMessages(List<ChatMessage> messages) async {
    await _chatMessageInsertionAdapter.insertList(
        messages, OnConflictStrategy.replace);
  }

  @override
  Future<void> addMessage(ChatMessage message) async {
    await _chatMessageInsertionAdapter.insert(
        message, OnConflictStrategy.replace);
  }
}
