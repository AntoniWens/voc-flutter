

import 'package:floor/floor.dart';

@Entity()
class ChatMessage {
  @PrimaryKey()
  String id;
  String chatId;
  String senderId;
  String message;
  String translationMsg;
  String attachmentType;
  String date;
  String time;
  String statusMessage;
  String replyMessageId;
  String replyMessage;
  String replyMsgSenderId;
  String replyTranslationMsg;
  String status;
  String createdAt;

  ChatMessage({
      required this.id,
      required this.chatId,
      required this.senderId,
      required this.message,
      required this.translationMsg,
      required this.attachmentType,
      required this.date,
      required this.time, required this.statusMessage, required this.replyMessageId, required this.replyMessage,required this.replyMsgSenderId,required this.replyTranslationMsg, required this.status,required this.createdAt});

}