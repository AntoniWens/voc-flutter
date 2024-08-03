import '../model/Message.dart';

class AllChatsResponse {
  bool error;
  String message;
  List<WData> data;

  AllChatsResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory AllChatsResponse.fromJson(Map<String, dynamic> json) => AllChatsResponse(
    error: json["error"],
    message: json["message"],
    data: List<WData>.from(json["data"].map((x) => WData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WData {
  String id;
  Message message;
  List<User> users;
  String date;
  String time;

  WData({
    required this.id,
    required this.message,
    required this.users,
    required this.date,
    required this.time
  });

  factory WData.fromJson(Map<String, dynamic> json) => WData(
    id: json["id"],
    message: Message.fromJson(json["message"]),
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message.toJson(),
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "date": date,
    "time": time,
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