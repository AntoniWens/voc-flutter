

import 'package:floor/floor.dart';

@Entity()
class AllChat {
  @PrimaryKey()
  String id;
  String senderId;
  String senderFullname;
  String senderLanguage;
  String receiverId;
  String receiverFullname;
  String receiverLanguage;
  String lastMessage;
  String translationMsg;
  String msgSenderId;
  String attachment;
  String attacmentType;
  String messageStatus;
  String date;
  String time;

  AllChat(
      this.id,
      this.senderId,
      this.senderFullname,
      this.senderLanguage,
      this.receiverId,
      this.receiverFullname,
      this.receiverLanguage,
      this.lastMessage,
      this.translationMsg,
      this.msgSenderId,
      this.attachment,
      this.attacmentType,
      this.messageStatus,
      this.date, this.time);
}