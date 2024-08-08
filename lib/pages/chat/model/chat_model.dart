
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:voc/local_service/message.dart';

import '../../../api_service/response/user_chat_response.dart';
import 'chatting.dart';

class ChatModel {
  RxList<UserChatData> chats = <UserChatData>[].obs;
  RxList<ChatMessage> messages = <ChatMessage>[].obs;

  RxDouble size = 0.0.obs;
  RxBool showOriginalText = false.obs;
  RxString replyMessage = ''.obs;
  RxString replyMsgSenderId = ''.obs;
  RxString replyMessageId = ''.obs;
  RxBool showScrollBottom = false.obs;
  RxBool showBtn = false.obs;
}