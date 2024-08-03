
import 'package:get/get.dart';

import '../controller/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }

}