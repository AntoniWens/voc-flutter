import 'package:get/get.dart';
import 'package:voc/pages/syncing/controller/syncing_controller.dart';

class SyncingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SyncingController());
  }

}