
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../api_service/auth.dart';
import '../../../api_service/response/login_response.dart';
import '../../../preferences.dart';
import '../../../route_management/routes.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  final model = LoginModel();
  final authService = Auth();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  void setPhoneCode(String code) {
    model.phoneCode.value = code;
    model.phoneCode.refresh();
  }

  void setVisiblePw(bool value) {
    model.isVisiblePw.value = value;
    model.isVisiblePw.refresh();
  }

  void checkEmpty() {
    model.isEmpty.value = phoneController.text.isEmpty || passwordController.text.isEmpty;
    model.isEmpty.refresh();
  }

  Future<void> login() async {
    model.isLoading.value = true;
    final token = await FirebaseMessaging.instance.getToken();
    final response = await authService.login(model.phoneCode.toString(), phoneController.text, passwordController.text, token.toString());
    if (response.runtimeType == LoginResponse) {
      final login = response as LoginResponse;
      if (!login.error) {
        await Preferences.saveToken(login.data!.token);
        await Preferences.saveUser(login.data!);
        Get.offAllNamed(Routes.syncing);
      } else {
        Fluttertoast.showToast(msg: login.message);
      }
      model.isLoading.value = false;
    } else {
      model.isLoading.value = false;
      Fluttertoast.showToast(msg: response.toString());
    }
    model.isLoading.refresh();
  }
}