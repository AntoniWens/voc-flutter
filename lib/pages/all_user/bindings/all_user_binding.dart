
import 'package:get/get.dart';

import '../controller/all_user_controller.dart';

class AllUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllUserController());
  }
  
}