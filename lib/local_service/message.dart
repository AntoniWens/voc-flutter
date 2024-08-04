

import 'package:floor/floor.dart';

@Entity()
class ChatMessage {
  @PrimaryKey()
  String id;
  String chatId;
  String senderId;
  String message;
  String translationMsg;
  String attachment;
  String attachmentType;
  String date;
  String time;
  String status;
  String replyMessageId;
  String replyMessage;

  ChatMessage(
      this.id,
      this.chatId,
      this.senderId,
      this.message,
      this.translationMsg,
      this.attachment,
      this.attachmentType,
      this.date,
      this.time, this.status, this.replyMessageId, this.replyMessage);
}