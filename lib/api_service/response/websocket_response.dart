import 'dart:convert';

import '../model/Message.dart';
import '../model/user.dart';

class WebsocketResponse {
  String? event;
  WData? data;
  String? channel;

  WebsocketResponse({
    required this.event,
    required this.data,
    required this.channel,
  });

  factory WebsocketResponse.fromJson(Map<String, dynamic> json) => WebsocketResponse(
    event: json['event'],
    data: json['data'] == null ? null : WData.fromJson(jsonDecode(json['data'])['result']),
    channel: json['channel']
  );

  Map<String, dynamic> toJson() => {
    "event": event,
    "data": data?.toJson(),
    "channel": channel,
  };
}

class WData {
  String id;
  Message? message;
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
    id: json["id"] ?? '',
    message: Message.fromJson(json['message']),
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message?.toJson(),
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "date": date,
    "time": time,
  };
}
