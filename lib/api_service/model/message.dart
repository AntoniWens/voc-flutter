import 'package:voc/api_service/model/sender.dart';

class Message {
  String id;
  String chatId;
  Sender sender;
  String message;
  String translationMsg;
  String attachmentType;
  String replyMessageId;
  String replyMessage;
  String status;
  String time;
  String date;

  Message({
    required this.id,
    required this.chatId,
    required this.sender,
    required this.message,
    required this.translationMsg,
    required this.attachmentType,
    required this.replyMessageId,
    required this.replyMessage,
    required this.status,
    required this.time,
    required this.date,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    chatId: json["chat_id"],
    sender: Sender.fromJson(json["sender"]),
    message: json["message"],
    translationMsg: json["translation_msg"],
    attachmentType: json["attachment_type"],
    replyMessageId: json["reply_message_id"] ?? '',
    replyMessage: json["reply_message"],
    status: json["status"],
    time: json["time"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat_id": chatId,
    "sender": sender.toJson(),
    "message": message,
    "translation_msg": translationMsg,
    "attachment_type": attachmentType,
    "reply_message_id": replyMessageId,
    "reply_message": replyMessage,
    "status": status,
    "time": time,
    "date": date,
  };
}