import 'package:get/get.dart';

class LoginModel {
  RxString phoneCode = '62'.obs;
  RxBool isEmpty = true.obs;
  RxBool isLoading = false.obs;
  RxBool isVisiblePw = false.obs;
}