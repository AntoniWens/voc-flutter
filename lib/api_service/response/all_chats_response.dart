
import '../model/message.dart';

class AllChatsResponse {
  bool error;
  String message;
  WData data;

  AllChatsResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory AllChatsResponse.fromJson(Map<String, dynamic> json) => AllChatsResponse(
    error: json["error"],
    message: json["message"],
    data: WData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  "data": data.toJson(),
  };
}

class WData {
  List<ChatM> chats;
  List<Message> messages;

  WData({
    required this.chats,
    required this.messages,
  });

  factory WData.fromJson(Map<String, dynamic> json) => WData(
    chats: List<ChatM>.from(json["chats"].map((x) => ChatM.fromJson(x))),
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}

class ChatM {
  String id;
  List<User> users;

  ChatM({
    required this.id,
    required this.users,
  });

  factory ChatM.fromJson(Map<String, dynamic> json) => ChatM(
    id: json["id"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  String id;
  String fullName;
  String language;

  User({
    required this.id,
    required this.fullName,
    required this.language,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["full_name"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "language": language,
  };
}