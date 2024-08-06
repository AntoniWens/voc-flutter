
import 'package:get/get.dart';
import 'package:voc/pages/main_page/service/connectivity_service.dart';

import '../controller/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
    Get.lazyPut(() => ConnectivityService());
  }

}