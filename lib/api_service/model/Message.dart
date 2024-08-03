class Message {
  String id;
  String chatId;
  String senderId;
  String message;
  String translationMsg;
  String attachment;
  String attachmentType;
  String status;
  String replyMessageId;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.message,
    required this.translationMsg,
    required this.attachment,
    required this.attachmentType,
    required this.status,
    required this.replyMessageId
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      id: json['id'],
      chatId: json['chat_id'] ?? '',
      senderId: json["sender_id"],
      message: json["message"],
      translationMsg: json["translation_msg"],
      attachment: json["attachment"],
      attachmentType: json["attachment_type"],
      status: json['status'],
    replyMessageId: json['reply_message_id']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'chat_id': chatId,
    "sender_id": senderId,
    "message": message,
    "translation_msg": translationMsg,
    "attachment": attachment,
    "attachment_type": attachmentType,
    'status': status,
    'reply_message_id': replyMessageId
  };
}