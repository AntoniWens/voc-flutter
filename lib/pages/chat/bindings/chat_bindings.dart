
import 'package:get/get.dart';

import '../controller/chat_controller.dart';

class ChatBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }

}