import '../model/message.dart';

class UpdateMessageResponse {
  bool error;
  String message;
  List<Message> data;

  UpdateMessageResponse({
    required this.error,
    required this.message,
    required this.data
  });

  factory UpdateMessageResponse.fromJson(Map<String, dynamic> json) => UpdateMessageResponse(
    error: json['error'],
    message: json['message'], data: List<Message>.from(json["data"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };
}