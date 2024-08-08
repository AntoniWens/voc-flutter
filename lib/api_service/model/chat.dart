class Chat {
  String id;
  String userOneId;
  String userOneFullname;
  String userOneLanguage;
  String userTwoId;
  String userTwoFullname;
  String userTwoLanguage;
  String lastMessage;
  String senderId;
  String translationMsg;
  String attachmentType;
  String messageStatus;

  String date;
  String time;

  Chat({
      required this.id,
      required this.userOneId,
      required this.userOneFullname,
      required this.userOneLanguage,
      required this.userTwoId,
      required this.userTwoFullname,
      required this.userTwoLanguage,
      required this.lastMessage,
    required this.senderId,
      required this.translationMsg,
      required this.attachmentType,
    required this.messageStatus,
      required this.date,
      required this.time});
}