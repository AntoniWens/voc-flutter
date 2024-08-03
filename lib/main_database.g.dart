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
            'CREATE TABLE IF NOT EXISTS `AllChat` (`id` TEXT NOT NULL, `senderId` TEXT NOT NULL, `senderFullname` TEXT NOT NULL, `senderLanguage` TEXT NOT NULL, `receiverId` TEXT NOT NULL, `receiverFullname` TEXT NOT NULL, `receiverLanguage` TEXT NOT NULL, `lastMessage` TEXT NOT NULL, `translationMsg` TEXT NOT NULL, `msgSenderId` TEXT NOT NULL, `attachment` TEXT NOT NULL, `attacmentType` TEXT NOT NULL, `messageStatus` TEXT NOT NULL, `date` TEXT NOT NULL, `time` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChatMessage` (`id` TEXT NOT NULL, `chatId` TEXT NOT NULL, `senderId` TEXT NOT NULL, `message` TEXT NOT NULL, `translationMsg` TEXT NOT NULL, `attachment` TEXT NOT NULL, `attachmentType` TEXT NOT NULL, `date` TEXT NOT NULL, `time` TEXT NOT NULL, `status` TEXT NOT NULL, PRIMARY KEY (`id`))');

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
                  'senderId': item.senderId,
                  'senderFullname': item.senderFullname,
                  'senderLanguage': item.senderLanguage,
                  'receiverId': item.receiverId,
                  'receiverFullname': item.receiverFullname,
                  'receiverLanguage': item.receiverLanguage,
                  'lastMessage': item.lastMessage,
                  'translationMsg': item.translationMsg,
                  'msgSenderId': item.msgSenderId,
                  'attachment': item.attachment,
                  'attacmentType': item.attacmentType,
                  'messageStatus': item.messageStatus,
                  'date': item.date,
                  'time': item.time
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
            row['id'] as String,
            row['senderId'] as String,
            row['senderFullname'] as String,
            row['senderLanguage'] as String,
            row['receiverId'] as String,
            row['receiverFullname'] as String,
            row['receiverLanguage'] as String,
            row['lastMessage'] as String,
            row['translationMsg'] as String,
            row['msgSenderId'] as String,
            row['attachment'] as String,
            row['attacmentType'] as String,
            row['messageStatus'] as String,
            row['date'] as String,
            row['time'] as String),
        queryableName: 'AllChat',
        isView: false);
  }

  @override
  Future<List<AllChat>> queryAllChats() async {
    return _queryAdapter.queryList('SELECT * FROM AllChat',
        mapper: (Map<String, Object?> row) => AllChat(
            row['id'] as String,
            row['senderId'] as String,
            row['senderFullname'] as String,
            row['senderLanguage'] as String,
            row['receiverId'] as String,
            row['receiverFullname'] as String,
            row['receiverLanguage'] as String,
            row['lastMessage'] as String,
            row['translationMsg'] as String,
            row['msgSenderId'] as String,
            row['attachment'] as String,
            row['attacmentType'] as String,
            row['messageStatus'] as String,
            row['date'] as String,
            row['time'] as String));
  }

  @override
  Future<AllChat?> getChat(
    String receiverId,
    String senderId,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM AllChat WHERE (senderId = ?2 AND receiverId = ?1) OR (senderId = ?1 AND receiverId = ?2)',
        mapper: (Map<String, Object?> row) => AllChat(row['id'] as String, row['senderId'] as String, row['senderFullname'] as String, row['senderLanguage'] as String, row['receiverId'] as String, row['receiverFullname'] as String, row['receiverLanguage'] as String, row['lastMessage'] as String, row['translationMsg'] as String, row['msgSenderId'] as String, row['attachment'] as String, row['attacmentType'] as String, row['messageStatus'] as String, row['date'] as String, row['time'] as String),
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
    String status,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE AllChat SET messageStatus = ?2 WHERE id = ?1',
        arguments: [id, status]);
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
                  'attachment': item.attachment,
                  'attachmentType': item.attachmentType,
                  'date': item.date,
                  'time': item.time,
                  'status': item.status
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ChatMessage> _chatMessageInsertionAdapter;

  @override
  Stream<List<ChatMessage>> getAllMessage(String chatId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM ChatMessage WHERE chatId =?1',
        mapper: (Map<String, Object?> row) => ChatMessage(
            row['id'] as String,
            row['chatId'] as String,
            row['senderId'] as String,
            row['message'] as String,
            row['translationMsg'] as String,
            row['attachment'] as String,
            row['attachmentType'] as String,
            row['date'] as String,
            row['time'] as String,
            row['status'] as String),
        arguments: [chatId],
        queryableName: 'ChatMessage',
        isView: false);
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
