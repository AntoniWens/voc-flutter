import 'package:voc/api_service/model/message.dart';

import '../model/user.dart';

class SendMessageResponse {
  bool error;
  String message;
  SendMessageData data;

  SendMessageResponse({
    required this.error,
    required this.message,
    required this.data
  });

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) => SendMessageResponse(
    error: json['error'],
    message: json['message'],
    data: SendMessageData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data.toJson(),
  };
}

class SendMessageData {
  String id;
  Message message;
  List<User> users;
  String date;
  String time;

  SendMessageData({
    required this.id,
    required this.message,
    required this.users,
    required this.date,
    required this.time
  });

  factory SendMessageData.fromJson(Map<String, dynamic> json) => SendMessageData(
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

