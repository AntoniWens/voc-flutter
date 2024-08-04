class UserChatResponse {
  bool error;
  String message;
  List<UserChatData> data;

  UserChatResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory UserChatResponse.fromJson(Map<String, dynamic> json) => UserChatResponse(
    error: json["error"],
    message: json["message"],
    data: List<UserChatData>.from(json["data"].map((x) => UserChatData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserChatData {
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

  UserChatData({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.message,
    required this.translationMsg,
    required this.attachment,
    required this.attachmentType,
    required this.date,
    required this.time,
    required this.status,
    required this.replyMessageId,
    required this.replyMessage
  });

  factory UserChatData.fromJson(Map<String, dynamic> json) => UserChatData(
    id: json["id"],
    chatId: json["chat_id"],
    senderId: json["sender_id"],
    message: json["message"],
    translationMsg: json["translation_msg"],
    attachment: json["attachment"],
    attachmentType: json["attachment_type"],
    date: json["date"],
    time: json['time'], status: json['status'], replyMessageId: json['reply_message_id'] ?? '', replyMessage: json['reply_message']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat_id": chatId,
    "sender_id": senderId,
    "message": message,
    "translation_msg": translationMsg,
    "attachment": attachment,
    "attachment_type": attachmentType,
    "date": date,
    'time': time,
    'status': status,
    'reply_message_id': replyMessageId,
    'reply_message': replyMessage
  };
}
