class SendMessageBody {
  String receiverId;
  String message;
  String id;
  String chatId;
  String replyMessageId;

  SendMessageBody(this.receiverId, this.message, this.id, this.chatId, this.replyMessageId);

  Map<String,dynamic> toJson() => {
    'receiver_id': receiverId,
    'message': message,
    'id': id,
    'chat_id': chatId,
    'reply_message_id': replyMessageId
  };
}