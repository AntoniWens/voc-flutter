
import '../../app_bar.dart';
import '../../library/otp_verification_field.dart';
import '../../route_management/routes.dart';
import '../../util.dart';
import '../../widget/bottom_privacy.dart';
import 'controller/email_verification_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../color_font_util.dart';

class EmailVerificationScreen extends GetWidget<EmailVerificationController> {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(true, 'email_verification'.tr),
      backgroundColor: ColorFontUtil.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                        child: Image.asset(
                      'assets/images/code_verification.png',
                      width: 250,
                      height: 250,
                    )),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'enter_verification_code'.tr,
                      style: TextStyle(
                          fontFamily: ColorFontUtil.poppins,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'enter_verification_code3'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: ColorFontUtil.poppins, fontSize: 12),
                    ),
                    Text(
                      Get.arguments['email'],
                      style: TextStyle(
                          fontFamily: ColorFontUtil.poppins, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    OtpVerificationField(onVerification: (code) async {
                      //await controller.register(code);
                      Get.toNamed(Routes.home);
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(() => RichText(
                        text: TextSpan(
                            text: 'dont_receive_otp'.tr,
                            style: TextStyle(
                                fontFamily: ColorFontUtil.poppins,
                                color: ColorFontUtil.black25),
                            children: [
                              controller.model.otpTime.value != 0 ? TextSpan(
                                text: ' ${Util.formatMMSS(controller.model.otpTime.value ~/ 1000)}',
                                style: TextStyle(
                                    fontFamily: ColorFontUtil.poppins,
                                    fontWeight: FontWeight.w500,
                                    color: ColorFontUtil.red02),
                              ) :TextSpan(
                                text: 'resend'.tr,
                                style: TextStyle(
                                    fontFamily: ColorFontUtil.poppins,
                                    fontWeight: FontWeight.bold,
                                    color: ColorFontUtil.red02),
                                recognizer: TapGestureRecognizer()..onTap = () async {
                                  await controller.sendOtp();
                                },
                              )
                            ])))

                  ],
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 24, left: 32, right: 32),
                child: BottomPrivacy()),
          ],
        ),
      ),
    );
  }
}
