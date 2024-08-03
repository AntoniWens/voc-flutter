
import 'package:get/get.dart';

import '../model/main_page_model.dart';

class MainPageController extends GetxController {
  final model = MainPageModel();

  void onItemTapped(int index) {
    model.selectedIndex.value = index;
    model.selectedIndex.refresh();
  }
}