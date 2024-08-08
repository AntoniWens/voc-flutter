
import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_bar.dart';
import '../../color_font_util.dart';
import '../../popup/selecting_language.dart';
import '../../popup/selecting_nation.dart';
import '../../popup/selecting_role.dart';
import '../../route_management/routes.dart';
import '../../widget/custom_drop_down.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/red_button.dart';
import 'controller/register_controller.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetWidget<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.appBar(true, 'register_now'.tr),
        backgroundColor: ColorFontUtil.grayFA,
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'register_now'.tr,
                        style: TextStyle(
                            fontFamily: ColorFontUtil.poppins,
                            fontSize: 34,
                            color: ColorFontUtil.red02,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'please_fill_your_information'.tr,
                        style: TextStyle(
                            fontFamily: ColorFontUtil.poppins,
                            fontSize: 14,
                            color: ColorFontUtil.black25,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Obx(
                        () => CustomTextField(
                          controller: controller.phoneController,
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(15),
                              child: RichText(
                                text: TextSpan(
                                    text:
                                        controller.model.phoneCode.value,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showCountryPicker(
                                            context: context,
                                            countryListTheme:
                                                CountryListThemeData(
                                              flagSize: 25,
                                              backgroundColor:
                                                  ColorFontUtil.white,
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: ColorFontUtil.black25,
                                                  fontFamily:
                                                      ColorFontUtil.poppins),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20.0),
                                              ),
                                              //Optional. Styles the search field.
                                              inputDecoration: InputDecoration(
                                                labelText: 'search'.tr,
                                                labelStyle: TextStyle(
                                                    fontFamily:
                                                        ColorFontUtil.poppins,
                                                    color:
                                                        ColorFontUtil.black25),
                                                hintText:
                                                    'start_typing_to_search'.tr,
                                                hintStyle: TextStyle(
                                                    fontFamily:
                                                        ColorFontUtil.poppins),
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  color: ColorFontUtil.grayC7,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: ColorFontUtil
                                                                .grayC7)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: ColorFontUtil
                                                                .grayC7)),
                                              ),
                                            ),
                                            onSelect: (Country country) {
                                              controller.setPhoneCode(
                                                  country.phoneCode);
                                            });
                                      },
                                    style: TextStyle(
                                        color: ColorFontUtil.black25,
                                        fontFamily: ColorFontUtil.poppins,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    children: const [
                                      WidgetSpan(
                                          child: Icon(Icons.arrow_drop_down))
                                    ]),
                              )),
                          hintText: 'Enter phone number'.tr,
                          label: 'phone_number_label'.tr,
                          textInputType: TextInputType.number,
                          onChanged: (v) {
                            controller.checkEmpty();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(() => CustomTextField(
                        controller: controller.emailController,
                        errorText: controller.model.emailErr.value,
                        hintText: 'email_hint'.tr,
                        label: 'email_label'.tr,
                        textInputType: TextInputType.emailAddress,
                        onChanged: (v) {

                          controller.emailValidation(v);
                          controller.checkEmpty();
                        },
                      ),),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: controller.fullNameController,
                        hintText: 'full_name_hint'.tr,
                        label: 'full_name_label'.tr,
                        textInputType: TextInputType.text,
                        onChanged: (v) {
                          controller.checkEmpty();
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => CustomTextField(
                          controller: controller.passwordController,
                          errorText: controller.model.passwordErr.value,
                          obscure: controller.model.passwordObscure.value,
                          suffixIcon: Padding(
                              padding: const EdgeInsets.all(15),
                              child: GestureDetector(
                                  onTap: () {
                                    controller.setVisibilityPassword();
                                  },
                                  child: Icon(
                                      controller.model.passwordObscure.value
                                          ? Icons.visibility_off
                                          : Icons.visibility))),
                          hintText: 'password_hint'.tr,
                          label: 'password_label'.tr,
                          textInputType: TextInputType.text,
                          onChanged: (v) {
                            controller.passwordValidation(v);
                            controller.passwordConfirmation(controller.confPasswordController.text);
                            controller.checkEmpty();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => CustomTextField(
                          controller: controller.confPasswordController,
                          errorText: controller.model.passwordConfErr.value,
                          obscure: controller.model.passwordConfObscure.value,
                          suffixIcon: Padding(
                              padding: const EdgeInsets.all(15),
                              child: GestureDetector(
                                  onTap: () {
                                    controller.setVisibilityPasswordC();
                                  },
                                  child: Icon(
                                      controller.model.passwordConfObscure.value
                                          ? Icons.visibility_off
                                          : Icons.visibility))),
                          hintText: 'password_conf_hint'.tr,
                          label: 'password_conf_label'.tr,
                          textInputType: TextInputType.text,
                          onChanged: (v) {
                            controller.passwordConfirmation(v);
                            controller.checkEmpty();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => CustomDropDown(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: ColorFontUtil.white,
                                isDismissible: false,
                                isScrollControlled: true,
                                builder: (context) {
                                  return SelectingRole(
                                      onTap: (value, id) {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        controller.setSelectedRole(value, id);
                                        controller.checkEmpty();
                                      },
                                      data: controller.model.roles);
                                });
                          },
                          selected: controller.model.selectedRole.value,
                          hint: 'Select Role',
                          label: 'Role',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => CustomDropDown(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: ColorFontUtil.white,
                                isDismissible: false,
                                isScrollControlled: true,
                                builder: (context) {
                                  return SelectingLanguage(
                                      onTap: (value, id) {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        controller.setSelectedLanguage(
                                            value, id);
                                        controller.checkEmpty();
                                      },
                                      data: controller.model.language);
                                });
                          },
                          selected: controller.model.selectedLanguage.value,
                          hint: 'Select Language',
                          label: 'Language',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(() => CustomDropDown(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: ColorFontUtil.white,
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return SelectingNation(
                                        onTap: (value, id) {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          controller.setSelectedNation(
                                              value, id);
                                          controller.checkEmpty();
                                        },
                                        data: controller.model.nation);
                                  });
                            },
                            selected: controller.model.selectedNation.value,
                            hint: 'Select Nationality',
                            label: 'Nationality',
                          ))
                    ],
                  ),
                ),
              ),
              Obx(() => Padding(
                padding: const EdgeInsets.only(top: 16),
                child: RedButton(
                    text: 'register'.tr,
                    isLoading: controller.model.isLoading.value,
                    isEmpty: controller.model.isEmpty.value,
                    onTap: controller.model.isEmpty.value
                        ? null
                        : () async {
                      await controller.sendOtp();
                    }),
              ))

            ],
          ),
        )));
  }
}
