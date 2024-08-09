import 'package:voc/api_service/model/message.dart';


class SendMessageResponse {
  bool error;
  String message;
  Message data;

  SendMessageResponse({
    required this.error,
    required this.message,
    required this.data
  });

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) => SendMessageResponse(
    error: json['error'],
    message: json['message'],
    data: Message.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data.toJson(),
  };
}

