import 'dart:async';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../api_service/auth.dart';
import '../../../api_service/body/register_body.dart';
import '../../../api_service/body/send_otp_body.dart';
import '../../../api_service/response/default_response.dart';
import '../../../api_service/response/login_response.dart';
import '../../../preferences.dart';
import '../../../route_management/routes.dart';
import '../model/phone_verification_model.dart';

class PhoneVerificationController extends GetxController {

  final model = PhoneVerificationModel();

  final authService = Auth();
  late Timer timer;

  void startTimer() {
    model.otpTime.value = 2 * 60000;
    const oneSec = Duration(milliseconds: 1000);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (model.otpTime.value == 0) {
          timer.cancel();
        } else {
          model.otpTime.value -= 1000;
        }
        model.otpTime.refresh();
      },
    );
  }

  Future<void> register(String otp) async {
    final token = await FirebaseMessaging.instance.getToken();
    final body = RegisterBody(
      otp,
      Get.arguments['country_code'],
      Get.arguments['phone_number'],
      Get.arguments['password'],
      Get.arguments['email'],
      Get.arguments['full_name'],
      Get.arguments['role'],
      Get.arguments['language'],
      Get.arguments['nationality'],
      token.toString()

    );
    final response = await authService.register(body);
    if (response.runtimeType == LoginResponse) {
      final regisRes = response as LoginResponse;
      if (!regisRes.error) {
          await Preferences.saveToken(regisRes.data!.token);
          await Preferences.saveUser(regisRes.data!);
          Get.offAllNamed(Routes.home);
      } else {
        Fluttertoast.showToast(msg: regisRes.message);
      }
    } else {
      Fluttertoast.showToast(msg: response.toString());
    }
  }

  Future<void> sendOtp() async {
    final body =
    SendOtpBody(Get.arguments['country_code'], Get.arguments['phone_number'], Get.arguments['email'], 'sms');
    final response = await authService.sendOtp(body);
    if (response.runtimeType == DefaultResponse) {
      final sendRes = response as DefaultResponse;
      if (!sendRes.error) {
        startTimer();
        Fluttertoast.showToast(msg: sendRes.message);
      } else {
        Fluttertoast.showToast(msg: sendRes.message);
      }
    } else {
      Fluttertoast.showToast(msg: response.toString());
    }
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  void stopTimer() {
    timer.cancel();
    model.otpTime.value = 0;
    model.otpTime.refresh();
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }
}