import 'dart:convert';

import '../model/message.dart';

class WebsocketResponse {
  String? event;
  Message? data;
  String? channel;

  WebsocketResponse({
    required this.event,
    required this.data,
    required this.channel,
  });

  factory WebsocketResponse.fromJson(Map<String, dynamic> json) => WebsocketResponse(
    event: json['event'],
    data: json['data'] == null ? null : Message.fromJson(jsonDecode(json['data'])['result']),
    channel: json['channel']
  );

  Map<String, dynamic> toJson() => {
    "event": event,
    "data": data?.toJson(),
    "channel": channel,
  };
}
