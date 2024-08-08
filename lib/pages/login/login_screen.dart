
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../app_bar.dart';
import '../../color_font_util.dart';
import '../../route_management/routes.dart';
import '../../widget/bottom_privacy.dart';
import '../../widget/red_button.dart';
import 'controller/login_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFontUtil.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 50,),
                    Center(
                        child: Image.asset(
                          'assets/images/v.jpg',
                          width: 250,
                          height: 250,
                        )),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      margin: const EdgeInsets.only(left: 32, right: 32, top: 40),
                      decoration: BoxDecoration(
                        color: ColorFontUtil.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: ColorFontUtil.black25.withOpacity(0.2),
                            spreadRadius: 0.2,
                            blurRadius: 0.5,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    flagSize: 25,
                                    backgroundColor: ColorFontUtil.white,
                                    textStyle: TextStyle(fontSize: 14, color: ColorFontUtil.black25, fontFamily: ColorFontUtil.poppins),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    //Optional. Styles the search field.
                                    inputDecoration: InputDecoration(
                                      labelText: 'search'.tr,
                                      labelStyle: TextStyle(
                                          fontFamily: ColorFontUtil.poppins,
                                        color: ColorFontUtil.black25
                                      ),
                                      hintText: 'start_typing_to_search'.tr,
                                      hintStyle: TextStyle(
                                        fontFamily: ColorFontUtil.poppins
                                      ),
                                      prefixIcon:  Icon(Icons.search, color: ColorFontUtil.grayC7,),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: ColorFontUtil.grayC7)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: ColorFontUtil.grayC7)
                                      ),
                                    ),
                                  ),
                                  onSelect: (Country country) {
                                    controller.setPhoneCode(country.phoneCode);
                                  }
                                );
                              },
                              child: Obx(() => Text(
                                 '+${controller.model.phoneCode.value}',
                                style: TextStyle(
                                    fontFamily: ColorFontUtil.poppins,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),)
                            ),
                            const Icon(Icons.arrow_drop_down),
                            Container(
                              width: 1,
                              margin: const EdgeInsets.only(left: 8),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0.0,
                                    blurRadius: 0.1,
                                    offset: const Offset(0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 8),
                                  child: TextFormField(
                                    controller: controller.phoneController,
                                    keyboardType: TextInputType.number,
                                    cursorColor: ColorFontUtil.red02,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                    ],
                                    style: TextStyle(
                                        fontFamily: ColorFontUtil.poppins, fontSize: 16),
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none),
                                    onChanged: (v) {
                                      controller.checkEmpty();
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      margin: const EdgeInsets.only(left: 32, right: 32, top: 8),
                      decoration: BoxDecoration(
                        color: ColorFontUtil.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: ColorFontUtil.black25.withOpacity(0.2),
                            spreadRadius: 0.2,
                            blurRadius: 0.5,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(() => TextFormField(
                              controller: controller.passwordController,
                              keyboardType: TextInputType.text,
                              cursorColor: ColorFontUtil.red02,
                              obscureText: controller.model.isVisiblePw.isFalse,
                              style: TextStyle(
                                  fontFamily: ColorFontUtil.poppins, fontSize: 16),
                              decoration:  const InputDecoration(
                                  hintText: 'Enter your password',
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none),
                              onChanged: (v) {
                                controller.checkEmpty();
                              },
                            ),)
                          ),
                          Obx(() => GestureDetector(onTap: () {
                            controller.setVisiblePw(!controller.model.isVisiblePw.value);
                          },child: Icon(controller.model.isVisiblePw.value ? Icons.visibility : Icons.visibility_off, color: ColorFontUtil.black25,)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: TextButton(onPressed: () {}, style: ButtonStyle(
                        textStyle: WidgetStatePropertyAll(
                          TextStyle(
                            color: ColorFontUtil.black25
                          )
                        )
                      ), child: Text('Forgot Password', style: TextStyle(
                        fontFamily: ColorFontUtil.poppins,
                        color: ColorFontUtil.black25,
                        fontWeight: FontWeight.w500,
                        fontSize: 13
                      ),)),
                    ),
                    const SizedBox(height: 8,),
                    Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: RedButton(text: 'login'.tr, isLoading: controller.model.isLoading.value, isEmpty: controller.model.isEmpty.value, onTap: controller.model.isEmpty.value ? null : () async {
                        await controller.login();
                      })
                    ),),
                    const SizedBox(height: 16,),
                    Center(
                      child: RichText(text: TextSpan(
                        style: TextStyle(
                          fontFamily: ColorFontUtil.poppins,
                          color: ColorFontUtil.black25
                        ),
                        text: "Don't have account?",
                        children: [
                          TextSpan(
                            text: ' Register now',
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Get.toNamed(Routes.register);
                            },
                            style: TextStyle(
                                fontFamily: ColorFontUtil.poppins,
                                color: ColorFontUtil.red15,
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ]
                      ), ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 24, left: 32, right: 32, top: 8),
              child: BottomPrivacy()
            ),
          ],
        ),
      ),
    );
  }
}
